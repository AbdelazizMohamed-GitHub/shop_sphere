import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_header.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_item.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_information.dart';
import 'package:uuid/uuid.dart';

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
            BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                 if (state is OrderError) {
                  Warning.showWarning(context, message: state.error,isError: true);
                } else if (state is OrderSuccess) {
                  Navigator.pop(context);
      
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        String orderId =
                            const Uuid().v4(); // Generate a new order ID
                        OrderModel orderModel = OrderModel.fromEntity(order);

                        await context.read<OrderCubit>().createOrder(
                            order: orderModel.copyWith(
                                orderId: orderId,
                                status:
                                    orderStauts[1], // Set status to 'Pending'
                                orderDate: DateTime.now(),
                                trackingNumber: 0));
                                Warning.showWarning(
                          context,
                          message: "Order Reordered Successfully",
                          isError: false,
                        );
                                
                      },
                      color: Colors.white,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black)),
                      child: state is CreateOrderLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator())
                          : Text(
                              'Reorder',
                              style: AppStyles.text16Bold
                                  .copyWith(color: Colors.black),
                            ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (order.status == orderStauts[3]) {
                          Navigator.pop(context);
                        } else {
                          if (!await AppFuncations.isOnline()) {
                            Warning.showWarning(
                              context,
                              message: "No Internet Connection",
                              isError: true,
                            );
                            return;
                          }

                          OrderModel orderModel = OrderModel.fromEntity(order);
                          await context
                              .read<OrderCubit>()
                              .deletOrder(order: orderModel);
                          Warning.showWarning(
                            context,
                            message: "Order Cancelled Successfully",
                            isError: false,
                          );
                        }
                      },
                      color: AppColors.primaryColor,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black)),
                      child: state is DeletOrderLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text(
                              order.status == orderStauts[3]
                                  ? 'Back'
                                  : 'Cancel Order',
                              style: AppStyles.text16Bold
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
