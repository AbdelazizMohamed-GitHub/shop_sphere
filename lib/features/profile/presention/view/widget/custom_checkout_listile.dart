import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomCheckoutListile extends StatelessWidget {
  const CustomCheckoutListile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.isSelect});
  final String title, subtitle;
  final IconData icon;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelect ? AppColors.primaryColor : Colors.white),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelect ? Colors.white : Colors.grey[200],
            ),
            child: Icon(
              icon,
              color: Colors.black,
            )),
        title: Text(
          title,
          style: AppStyles.text16BoldBlack
              .copyWith(color: isSelect ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          subtitle,
          style: AppStyles.text16RegularBlack
              .copyWith(color: isSelect ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
