// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomProductTitleSection extends StatelessWidget {
  const CustomProductTitleSection({
    super.key,
    required this.title,
    required this.funcation,
  });

  final String title;
  final void Function()? funcation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.text22SemiBold,
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          TextButton(
              onPressed: funcation,
              child:const Text(
                'See All',
                style: AppStyles.text18Regular,
              ))
        ],
      ),
    );
  }
}
