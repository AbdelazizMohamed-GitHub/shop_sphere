import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCircleButton(
          icon: const Icon(Icons.arrow_back_ios),
          funcation: () {
            Navigator.pop(context);
          },
        );
  }
}