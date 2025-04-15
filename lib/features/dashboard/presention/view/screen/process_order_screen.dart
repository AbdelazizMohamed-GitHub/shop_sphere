import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_process_screen_item.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class ProcessOrderScreen extends StatelessWidget {
  const ProcessOrderScreen({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
        title: const Text('Process Order'),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            CustomProcessScreenItem(
                title: "Order Date",
                subTitle: DateFormat.yMMMEd().format(order.orderDate)),
            const Divider(height: 20),
            CustomProcessScreenItem(
                title: "Order ID",
                subTitle: "${order.orderId.substring(0, 6)}"),
            const Divider(height: 20),
            CustomProcessScreenItem(
                title: "Order Status", subTitle: order.status),
            const Divider(height: 20),
            CustomProcessScreenItem(
              title: "Customer Name",
              subTitle: order.userName,
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Shipping Address", style: AppStyles.text18Regular),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    "${order.address.street} , ${order.address.state} , ${order.address.city}  , ${order.address.phoneNumber}",
                    style: AppStyles.text14Regular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          order.status==orderStauts[0]?  BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is OrderSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    state is DeletOrderLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onPressed: () async {
                              await context
                                  .read<OrderCubit>()
                                  .deletOrder(orderId: order.orderId);
                            },
                            text: "Cancel Order",
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                    const SizedBox(height: 20),
                    state is UpdateOrderLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onPressed: () async {
                              context.read<OrderCubit>().changeOrdeStatus(
                                  status: orderStauts[1],
                                  orderId: order.orderId);
                            },
                            text: "Process Order"),
                  ],
                );
              },
            ):const SizedBox()
          ]
        ),
      ),
    );
  }
}
