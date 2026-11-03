import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "Disvcover the joy of effortless hopping with shopSphere",
                textAlign: TextAlign.center,
                style: AppStyles.text22SemiBold),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                  context.pushNamed(AppRoute.onboarding);
                },
                text: "Get Started")
          ],
        ),
      ),
    );
  }
}
