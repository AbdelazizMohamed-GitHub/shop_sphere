import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_header.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_item.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_information.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                )),
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOrderDetailsHeader(order: order),
            const SizedBox(height: 20),
            Text(
              '${order.items.length} Items',
              style: AppStyles.text18Regular,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  return CustomOrderDetailsItem(item: order.items[index]);
                },
              ),
            ),
            CustomOrderInformation(order: order),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () async {
                    OrderModel orderModel = OrderModel.fromEntity(order);

                    await context
                        .read<OrderCubit>()
                        .createOrder(order: orderModel);
                  },
                  color: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black)),
                  child: Text(
                    'Reorder',
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (order.status == orderStauts[3]) {
                      Navigator.pop(context);
                    } else {
                      await context
                          .read<OrderCubit>()
                          .deletOrder(orderId: order.orderId);
                    }
                  },
                  color: AppColors.primaryColor,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black)),
                  child: Text(
                    order.status == orderStauts[3]?'Cancel': 'Cancel Order',
                    style: AppStyles.text16Bold.copyWith(color: Colors.white),
                  ),
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
