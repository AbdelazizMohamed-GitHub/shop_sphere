import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';

class CustomOrderDetailsHeader extends StatelessWidget {
  const CustomOrderDetailsHeader({super.key, required this.order});
  final Map<String, dynamic> order;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
                  Row(
              children: [
                Text(
                  'Order ID: ${order['id']}',
                  style: AppStyles.text18RegularBlack,
                ),
                const Spacer(),
                Text(
                  '${order["date"]}',
                  style: AppStyles.text14RegularBlack,
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
                      color: Funcations.getStatusColor(order['status'])),
                ),
              ],
            ),
    ],);
  }
}