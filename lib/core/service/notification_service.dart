// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart'
    show
        ActionType,
        AwesomeNotifications,
        NotificationCategory,
        NotificationChannel,
        NotificationContent,
        NotificationImportance,
        NotificationLayout,
        ReceivedAction;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/features/main/data/notification_model.dart';

@pragma('vm:entry-point')
Future<void> onNotificationActionReceived(ReceivedAction action) async {
  final productId = action.payload?['productId'];
  if (productId != null && productId.isNotEmpty) {
    NotificationService.openProductFromNotification(productId);
  }
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static void Function(String productId)? _productTapHandler;
  static String? _pendingProductId;

  static const _scope = 'https://www.googleapis.com/auth/firebase.messaging';
  static const projectId = 'shopsphere-b422e';
  static const _messagingUrl =
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

  // ----------- Initialization -----------

  static Future<void> initialize() async {
    await _messaging.requestPermission();
    _notificationMessage();
  }

  static void setProductTapHandler(void Function(String productId) handler) {
    _productTapHandler = handler;
    final pendingProductId = _pendingProductId;
    if (pendingProductId != null) {
      _pendingProductId = null;
      handler(pendingProductId);
    }
  }

  static void openProductFromNotification(String productId) {
    final normalizedId = productId.trim();
    if (normalizedId.isEmpty) return;

    final handler = _productTapHandler;
    if (handler == null) {
      _pendingProductId = normalizedId;
      return;
    }

    handler(normalizedId);
  }

  static void _notificationMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("📩 onMessage (foreground): ${message.notification?.body}");
      await showNotification(message: message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 onMessageOpenedApp: ${message.notification?.body}");
      openProductFromNotification(message.data['productId']?.toString() ?? '');
    });

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print("📦 getInitialMessage: ${initialMessage.notification?.title}");
      openProductFromNotification(
          initialMessage.data['productId']?.toString() ?? '');
    }
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  // ----------- Sending Notification -----------

  static Future<ServiceAccountCredentials> _loadServiceAccount() async {
    final jsonString =
        await rootBundle.loadString('assets/firebase_service_account.json');
    final jsonMap = jsonDecode(jsonString);
    return ServiceAccountCredentials.fromJson(jsonMap);
  }

  static Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
    required String productId,
    required String imageUrl,
  }) async {
    final credentials = await _loadServiceAccount();
    final client = await clientViaServiceAccount(credentials, [_scope]);

    final message = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
          'image': imageUrl,
        },
        'data': {
          'type': 'product_offer',
          'productId': productId,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'android': {
          'notification': {
            'image': imageUrl,
            'channel_id': 'high_importance_channel',
          },
        },
      },
    };

    try {
      final response = await client.post(
        Uri.parse(_messagingUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('🎉 Notification sent successfully!');
      } else {
        print('🤯 Failed to send notification: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
    } finally {
      client.close();
    }
  }

  static Future<void> saveNotification({
    required String title,
    required String body,
    String? productId,
    String? imageUrl,
  }) async {
    final notification = NotificationModel(
      title: title,
      description: body,
      date: DateTime.now(),
      productId: productId,
      imageUrl: imageUrl,
    );

    final box = Hive.box<NotificationModel>(AppConst.appNotificationBox);
    await box.add(notification);
  }

  static Future<void> initializeLocalNotifications() async {
    if (kIsWeb) {
      debugPrint('Local notifications are not supported on web. Skipping.');
      return;
    }

    await AwesomeNotifications().initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'basic_channel',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          enableVibration: true,
        ),
      ],
    );

    final listenersSet = await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onNotificationActionReceived,
    );
    if (!listenersSet) {
      debugPrint('Could not register notification tap handler.');
    }
  }

  static Future<void> showNotification({required RemoteMessage message}) async {
    final title = message.notification?.title ?? 'ShopSphere offer';
    final body = message.notification?.body ?? '';
    final productId = message.data['productId']?.toString();
    final imageUrl = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        message.data['imageUrl']?.toString();
    await saveNotification(
      title: title,
      body: body,
      productId: productId,
      imageUrl: imageUrl,
    );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 100,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Message,
        autoDismissible: true,
        payload: {
          'image': AppImages.logo,
          'title': title,
          'body': body,
          if (productId != null) 'productId': productId,
        },
        actionType: ActionType.Default,
        displayOnBackground: true,
      ),
    );
  }
}
