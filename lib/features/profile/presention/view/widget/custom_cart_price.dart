// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomCartPrice extends StatelessWidget {
  const CustomCartPrice({
    super.key,
    required this.title,
    required this.price,
    this.isTotalcoast = false,
  });
  final String title;
  final double price;
  final bool isTotalcoast;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.text22SemiBold),
        Text(
          '${price.toStringAsFixed(1)} EGP',
          style: isTotalcoast
              ? AppStyles.text18Regular.copyWith(color: Colors.green)
              : AppStyles.text18Regular.copyWith(
                  color: AppTheme.isLightTheme(context)
                      ? Colors.black
                      : Colors.white),
        ),
      ],
    );
  }
}
