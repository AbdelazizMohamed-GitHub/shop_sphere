import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomIconLoading extends StatelessWidget {
  const CustomIconLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: true,
      child: CustomCircleButton(
          icon: const Icon(Icons.refresh), funcation: () {}),
    );
  }
}
