// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.item,
  });
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.isLightTheme(context)
          ? Colors.white
          : AppColors.secondaryDarkColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.isLightTheme(context)
                ? Colors.white
                : AppColors.backgroundDarkColor,
          ),
          child: Image.asset(
            AppImages.product,
            width: 60,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          item['name'],
          style: AppStyles.text18Regular.copyWith(
              color:
                  AppTheme.isLightTheme(context) ? Colors.black : Colors.white),
        ),
        subtitle:
            Text('\$${item['price'].toStringAsFixed(2)} x ${item['quantity']}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {},
        ),
      ),
    );
  }
}
