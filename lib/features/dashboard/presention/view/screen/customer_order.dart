// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class CustomerOrderScreen extends StatelessWidget {
  const CustomerOrderScreen({
    Key? key,
    required this.userId,
    required this.userNane,
  }) : super(key: key);
  final String userId;
  final String userNane;

  @override
  Widget build(BuildContext context) {
    // Dummy order data

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text('Order #${order['orderId']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${order['date']}'),
                      Text('Status: ${order['status']}'),
                    ],
                  ),
                  trailing: Text('\$${order['total']}'),
                  onTap: () {
                    // Navigate to order details if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
