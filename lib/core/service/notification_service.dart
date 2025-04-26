  import 'package:http/http.dart' as http;
import 'dart:convert';

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


Future<void> sendPushMessage(String token, String title, String body) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=YOUR_SERVER_KEY', // from Firebase Console
      },
      body: jsonEncode({
        'to': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
      }),
    );
  } catch (e) {
    print("Error sending push notification: $e");
  }
}
}
