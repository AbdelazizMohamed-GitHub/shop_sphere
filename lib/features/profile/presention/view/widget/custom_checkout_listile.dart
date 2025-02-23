import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomCheckoutListile extends StatelessWidget {
  const CustomCheckoutListile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});
  final String title, subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Icon(
            icon,
            color: Colors.black,
          )),
      title: Text(
        title,
        style: AppStyles.text16BoldBlack,
      ),
      subtitle: Text(
        subtitle,
        style: AppStyles.text16RegularBlack,
      ),
    );
  }
}
