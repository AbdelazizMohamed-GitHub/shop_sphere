import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    if (!navigator.canPop()) {
      return const SizedBox.shrink();
    }

    return CustomCircleButton(
      icon: const Icon(Icons.arrow_back_ios),
      funcation: () {
        navigator.pop();
      },
    );
  }
}