  import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // طلب الإذن
    await _messaging.requestPermission();

    // الحصول على FCM token (ممكن تحفظه في Firestore)
   
    // التطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 onMessage (foreground): ${message.notification?.title}");
      // هنا تقدر تظهر Dialog أو Snackbar حسب حاجتك
    });

    // التطبيق في الخلفية وتم فتحه من الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚪 onMessageOpenedApp: ${message.notification?.title}");
      // هنا تقدر تنقل المستخدم لصفحة معينة
    });

    // التطبيق مغلق وتم فتحه عن طريق إشعار
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print("📦 getInitialMessage: ${initialMessage.notification?.title}");
      // التعامل مع الحالة هذه
    }
  }
 static Future<String?> getToken() async {
    String? token = await _messaging.getToken();
    
    return token;
    
  }



  static const _scope = 'https://www.googleapis.com/auth/firebase.messaging';
  static const projectId = 'shopsphere-b422e'; // عدله باسم مشروعك
  static const _messagingUrl = 'https://fcm.googleapis.com/v1/projects/shopsphere-b422e/messages:send';

  static Future<ServiceAccountCredentials> _loadServiceAccount() async {
    final jsonString = await rootBundle.loadString('assets/firebase_service_account.json');
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

    client.close();
  }
}






