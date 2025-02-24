import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_item.dart';

class CustomOrderScreenBody extends StatelessWidget {
  const CustomOrderScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
          controller: context.read<OrderCubit>().pageController,
          onPageChanged: (index) {
            context.read<OrderCubit>().pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
            context.read<OrderCubit>().changeOrderStatus(index);
          },
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomOrderItem();
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomOrderItem();
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomOrderItem();
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomOrderItem();
              },
            ),
          ]),
    );
  }
}
