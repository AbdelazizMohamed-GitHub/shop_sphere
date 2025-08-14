import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_order_items.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_process_screen_item.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class OrdersDetailsScreen extends StatefulWidget {
  const OrdersDetailsScreen({
    super.key,
    required this.order,
  });
  final OrderEntity order;

  @override
  State<OrdersDetailsScreen> createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  @override
  void initState() {
    order = widget.order;
    super.initState();
  }

  late OrderEntity order;
  @override
  Widget build(BuildContext context) {
     final isDesktop = ResponsiveLayout.isDesktop(context);
    double horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context);
    return Scaffold(
      appBar:isDesktop? null : AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
        title: const Text('Order Details'),
        leadingWidth: 100,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomOrderItemDashboard(
                  orderEntity: order,
                ),
                const Divider(height: 20),
                CustomProcessScreenItem(
                    title: "Order Date",
                    subTitle: DateFormat.yMMMEd().format(order.orderDate)),
                const Divider(height: 20),
                CustomProcessScreenItem(
                    title: "Tracking Number",
                    subTitle: order.trackingNumber.toString()),
                const Divider(height: 20),
                CustomProcessScreenItem(
                    title: "Order Status", subTitle: widget.order.status),
                const Divider(height: 20),
                CustomProcessScreenItem(
                  title: "Customer Name",
                  subTitle: order.userName,
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping Address",
                        style: AppStyles.text18Regular),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        "${order.address.street} , ${order.address.city} , ${order.address.state}  , ${order.address.phoneNumber}",
                        style: AppStyles.text14Regular.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                order.status == orderStauts[3]
                    ? Text(
                        "Order Delivered",
                        style: AppStyles.text18Regular.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : BlocConsumer<OrderCubit, OrderState>(
                        listener: (context, state) {
                          if (state is OrderError) {
                            Warning.showWarning(
                              context,
                              message: state.error,
                              isError: true,
                            );
                          }
                          if (state is OrderSuccess) {
                            Navigator.pop(context);
                            context
                                .read<OrderCubit>()
                                .getCustomerOrder(uId: order.uId);
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
                                        OrderModel orderModel =
                                            OrderModel.fromEntity(order);
                                        await context
                                            .read<OrderCubit>()
                                            .deletOrder(order: orderModel);
                                      },
                                      text: "Cancel Order",
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    ),
                              const SizedBox(height: 20),
                              widget.order.status == orderStauts[1]
                                  ? state is UpdateOrderLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomButton(
                                          onPressed: () async {
                                            await context
                                                .read<OrderCubit>()
                                                .getTrackinNumber();
                                            await context
                                                .read<OrderCubit>()
                                                .changeOrdeStatus(
                                                    status: orderStauts[2],
                                                    orderId: order.orderId,
                                                    trackingNumber: context
                                                        .read<OrderCubit>()
                                                        .currentTrackingNumber);
                                          },
                                          text: "Process Order")
                                  : state is UpdateOrderLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomButton(
                                          onPressed: () async {
                                            await context
                                                .read<OrderCubit>()
                                                .changeOrdeStatus(
                                                    status: orderStauts[3],
                                                    orderId: order.orderId,
                                                    trackingNumber:
                                                        order.trackingNumber);
                                          },
                                          text: "Deliver Order")
                            ],
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
