import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class CustomOrderDetailsHeader extends StatelessWidget {
  const CustomOrderDetailsHeader({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Order ID: ${order.orderId.substring(0, 6)}',
              style: AppTheme.isLightTheme(context)
                  ? AppStyles.text18Regular
                  : AppStyles.text18RegularWhite,
            ),
            const Spacer(),
            Text(
              DateFormat.yMMMEd().format(order.orderDate),
              style: AppStyles.text14Regular,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
             Text('Tracking Number: ${order.status=='Delivered'?order.trackingNumber.toString():"******"}',style: AppStyles.text16Regular,),
            const Spacer(),
            Text(
              ' ${order.status}',
              style: TextStyle(
                  fontSize: 16,
                  color: AppFuncations.getStatusColor(order.status)),
            ),
          ],
        ),
      ],
    );
  }
}
