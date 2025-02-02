import 'package:flutter/material.dart';
import 'package:shop_sphere/features/presention/view/screen/onboarding_screen.dart';

void main() {
  runApp(const ShopSphere());
}

class ShopSphere extends StatelessWidget {
  const ShopSphere
({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:OnboardingScreen() ,);
  }
}