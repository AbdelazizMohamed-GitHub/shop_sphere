import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomOnboardingItem extends StatelessWidget {
  const CustomOnboardingItem(
      {super.key,
    
      required this.bodyImage,
      required this.bodyText});

 
  final String bodyImage;
  final String bodyText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          bodyImage,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(bodyText, textAlign: TextAlign.center, style: AppStyles.text26BoldBlack)
      ],
    );
  }
}
