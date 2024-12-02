import 'package:flutter/material.dart';
import 'package:shop_sphere/Feature/Auth/presention/view/screen/login_screen.dart';

void main() {
  runApp(const ShopSphere());
}

class ShopSphere extends StatelessWidget {
  const ShopSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
