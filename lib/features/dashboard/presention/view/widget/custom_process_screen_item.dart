// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomProcessScreenItem extends StatelessWidget {
  const CustomProcessScreenItem({
    super.key,
    required this.title,required this.subTitle,
  });
final String title,subTitle;
  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppStyles.text18Regular),
                Text(subTitle, style: AppStyles.text16Bold),
              ],
            );
  }
}
