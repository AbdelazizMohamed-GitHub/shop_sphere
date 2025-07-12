// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomChartTitle extends StatelessWidget {
  const CustomChartTitle({
    super.key,
    required this.title,
    required this.onViewAll,
  });
final String title;
final VoidCallback onViewAll;
  @override
  Widget build(BuildContext context) {
    return   Row(children: [
               Text(
                title,
                style: AppStyles.text18Regular,
              ),
              const Spacer(),
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed:onViewAll ,
                label: const Text("View All"),
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
              )
            ]);
  }
}
