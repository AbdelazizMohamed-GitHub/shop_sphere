import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_syles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';

import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appLogo,
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            const Text('Shop Sphere', style: AppStyles.text30Bold),
            Text(
              'Discover the joy of effortless shopping with ShopSphere',
              textAlign: TextAlign.center,
              style: AppStyles.text22RegularWhite.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                text: 'Get Started'),
          ],
        ),
      ),
    );
  }
}
