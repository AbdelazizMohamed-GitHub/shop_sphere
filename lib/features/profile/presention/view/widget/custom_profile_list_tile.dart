// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.funcation,
  });
  final IconData icon;
  final String title;
 final void Function()funcation;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(icon),
      title: Text(title),titleTextStyle: AppStyles.text18RegularWhite,
      trailing:
          IconButton(onPressed: funcation, icon:const Icon(Icons.arrow_forward_ios)),
    );
    
  }
}
