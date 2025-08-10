// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({
    super.key,
    required this.userId,
    required this.userName,
  });
  final String userId;
  final String userName;

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  @override
  void initState() {
    context.read<OrderCubit>().getCustomerOrder(uId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = ResponsiveLayout.getHorizontalLargePadding(
        context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          '${widget.userName} Orders',
          style: AppStyles.text18Regular,
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state is OrderSuccess
              ? state.orders.isEmpty
                  ? const Center(child: Text('No orders found'))
                  : ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        OrderEntity order = state.orders[index];
                        return Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              horizontal: horizontalPadding, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              context.go(
                                '${AppRoute.orderDetails}/${order.items[0].productName}',
                                extra: order,
                              );
                            },
                            child: ListTile(
                              leading: const Icon(Icons.shopping_bag),
                              title: Text(
                                  'Tracking Number: ${order.status == 'Pending' ? '******' : order.trackingNumber}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Date: ${DateFormat.yMMMEd().format(order.orderDate)}'),
                                  Text(
                                    ' ${order.status}',
                                    style: TextStyle(
                                        color: AppFuncations.getStatusColor(
                                            order.status)),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '\$${order.totalAmount}',
                                style: AppStyles.text16Bold,
                              ),
                            ),
                          ),
                        );
                      },
                    )
              : state is GetOrderLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is OrderError
                      ? CustomErrorWidget(
                          errorMessage: state.error,
                          onpressed: () async {
                            await context
                                .read<OrderCubit>()
                                .getCustomerOrder(uId: widget.userId);
                          },
                        )
                      : const Center(
                          child: Text('No orders found'),
                        );
        },
      ),
    );
  }
}
