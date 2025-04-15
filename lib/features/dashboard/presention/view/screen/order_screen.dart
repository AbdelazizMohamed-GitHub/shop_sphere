import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_order_items.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).getOrders(status: "all");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
        title: const Text('All Order'),
        leadingWidth: 100,
      ),
      body:  BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          List<OrderEntity> orders = [];
          if (state is GetOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderError) {
            return Center(child: Text(state.error));
    
          }
          if (state is OrderSuccess) {
            orders = state.orders;
          }
          if (orders.isEmpty) {
            return const Center(child: Text("No Orders Found"));
          }
          return Padding(
                padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: ListView.builder(
                  itemCount:orders.length ,
                  itemBuilder: (BuildContext context, int index) {
                    return  CustomOrderItem(orderEntity:orders[index]);
                  },
                ),
              );
        },
      ),
    );
  }
}
