// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomNotificationItem extends StatelessWidget {
  const CustomNotificationItem({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.isLightTheme(context)
          ? Colors.white
          : AppColors.secondaryDarkColor,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: index % 2 == 0
            ? const Icon(Icons.notifications,
                size: 40, color: AppColors.primaryColor)
            : Image.asset(
                AppImages.product,
                fit: BoxFit.fill,
              ),
       
      ),
    );
  }
}
