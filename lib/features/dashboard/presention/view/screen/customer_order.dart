// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
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
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrdersDetailsScreen(
                                  order: order,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: const Icon(Icons.shopping_bag),
                              title: Text('Tracking #${order.trackingNumber}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date: ${order.orderDate.toLocal()}'),
                                  Text('Status: ${order.status}'),
                                ],
                              ),
                              trailing: Text('\$${order.totalAmount}'),
                              onTap: () {
                                // Navigate to order details if needed
                              },
                            ),
                          ),
                        );
                      },
                    )
              : state is GetOrderLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is OrderError
                      ? Center(child: Text(state.error))
                      : const Center(child: Text('No orders found'));
        },
      ),
    );
  }
}
