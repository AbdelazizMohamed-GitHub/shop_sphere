// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/features/main/data/notification_model.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static const _scope = 'https://www.googleapis.com/auth/firebase.messaging';
  static const projectId = 'shopsphere-b422e';
  static const _messagingUrl =
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

  // ----------- Initialization -----------

  static Future<void> initialize() async {
    await _messaging.requestPermission();
    _notificationMessage();
  }

  static void _notificationMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 onMessage (foreground): ${message.notification?.body}");
      saveNotification(title: message.notification!.title!, body: message.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚪 onMessageOpenedApp: ${message.notification?.title}");
    });

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print("📦 getInitialMessage: ${initialMessage.notification?.title}");
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
  }) async {
    final credentials = await _loadServiceAccount();
    final client = await clientViaServiceAccount(credentials, [_scope]);

    final message = {
      "message": {
        "token": token,
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "done",
        },
      }
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

 static Future<void> saveNotification(
      {required String title, required String body}) async {
    final notification = NotificationModel(
      title: title,
      description: body,
      date: DateTime.now(),
    );

    final box = Hive.box<NotificationModel>(AppConst.appNotificationBox);
    await box.add(notification);
  }
}
