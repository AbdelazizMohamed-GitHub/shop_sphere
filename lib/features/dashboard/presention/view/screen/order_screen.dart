import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere_dashboard/core/test_data/test_list.dart';
import 'package:shop_sphere_dashboard/features/presention/view/controller/order/order_cubit.dart';
import 'package:shop_sphere_dashboard/features/presention/view/widget/custom_order_items.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 30),
          ),
          title: const Text('All Order'),
          leadingWidth: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              CustomOrderItem(item: TestList.cartItems[0]),
              CustomOrderItem(item: TestList.cartItems[1]),
            ],
          ),
        ),
      ),
    );
  }
}
