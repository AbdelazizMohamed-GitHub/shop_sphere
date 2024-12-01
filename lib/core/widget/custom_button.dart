import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_colors.dart';
import 'package:shop_sphere/core/constant/app_syles.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      onPressed: onPressed,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: AppStyles.text22Regular),
    );
  }
}
