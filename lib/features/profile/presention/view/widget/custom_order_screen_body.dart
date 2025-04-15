// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_item.dart';

class CustomOrderScreenBody extends StatelessWidget {
  const CustomOrderScreenBody({
    super.key,
    required this.orders,
  });
  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
          controller: context.read<OrderCubit>().pageController,
          onPageChanged: (index) {
            context.read<OrderCubit>().changeOrderStatus(index);
            context.read<OrderCubit>().pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          },
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CustomOrderItem(
                  order: orders[index],
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CustomOrderItem(order: orders[index]);
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CustomOrderItem(order: orders[index]);
              },
            ),
          ]),
    );
  }
}
