import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_details_screen.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({
    super.key,
    required this.order,
  });
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Card(
          color: AppTheme.isLightTheme(context)
              ? Colors.white
              : AppColors.secondaryDarkColor,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'Order ID: ${order.orderId.substring(0, 6)}',
                    style: AppStyles.text16Bold,
                  ),
                  const Spacer(),
                  Text(
                    DateFormat.yMMMEd().format(order.orderDate),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Tracking Number:  ${order.status == 'Delivered' ? order.trackingNumber : '******'}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Quantity: ${order.items.length} ',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'Total: \$${order.totalAmount}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(children: [
                  MaterialButton(
                    color: AppColors.primaryColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailsScreen(order: order),
                          ));
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    ' ${order.status}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: order.status == 'Delivered'
                            ? Colors.green
                            : order.status == 'Processing'
                                ? Colors.orange
                                : Colors.red),
                  )
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}
