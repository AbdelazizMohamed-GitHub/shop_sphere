import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/features/onboarding/presention/view/screen/get_started_screen.dart';
import 'package:shop_sphere/shopsphere_app.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // المستخدم مسجل دخول، استكمل تحميل بياناته
          return const ShopSphere();
        } else {
          // المستخدم غير مسجل دخول
          return const GetStartedScreen();
        }
      },
    );
  }
}
