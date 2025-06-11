// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);
  final String userId;
  final String userName;

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  @override
  void initState() {
    context.read<OrderCubit>().getUserOrders(status: 'All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userName}\'s Orders'),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state is OrderSuccess
              ? ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    OrderEntity order = state.orders[index];
                    return Card(
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
                        trailing: Text('\$${order.totalAmount }'),
                        onTap: () {
                          // Navigate to order details if needed
                        },
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
