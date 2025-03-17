import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class CustomOrderDetailsHeader extends StatelessWidget {
  const CustomOrderDetailsHeader({super.key, required this.order});
  final Map<String, dynamic> order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Order ID: ${order['id']}',
              style: AppTheme.isLightTheme(context)
                  ? AppStyles.text18Regular
                  : AppStyles.text18RegularWhite,
            ),
            const Spacer(),
            Text(
              '${order["date"]}',
              style: AppStyles.text14Regular,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Tracking Number: 1234567890'),
            const Spacer(),
            Text(
              ' ${order['status']}',
              style: TextStyle(
                  fontSize: 16,
                  color: AppFuncations.getStatusColor(order['status'])),
            ),
          ],
        ),
      ],
    );
  }
}
