import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomCheckoutListile extends StatelessWidget {
  const CustomCheckoutListile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.isSelect});
  final String title, subtitle;
  final Widget icon;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 10),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelect
              ? AppColors.primaryColor
              : AppTheme.isLightTheme(context)
                  ? Colors.white
                  : AppColors.secondaryDarkColor),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelect ? Colors.white : Colors.grey[200],
            ),
            child: icon),
        title: Text(
          title,
          style: AppStyles.text16Bold.copyWith(
              color: isSelect
                  ? Colors.white
                  : AppTheme.isLightTheme(context)
                      ? Colors.black
                      : Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: AppStyles.text16Regular.copyWith(
              color: isSelect
                  ? Colors.white
                  : AppTheme.isLightTheme(context)
                      ? Colors.black
                      : Colors.white),
        ),
      ),
    );
  }
}
