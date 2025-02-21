import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/test/test_list.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_details_screen.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Row(children: [
                  Text(
                    'Order # 19470',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    ' 26-12-2022',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'Tracking Number: 1234567890',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'Quantity:3 ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'Total: \$ 100.0',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(children: [
                  MaterialButton(
                    color: AppColors.primaryColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(order: TestList.order),
                          ));
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  Text(
                      TestList.orderStauts[
                          context.read<OrderCubit>().currentStatus],
                      style: const TextStyle(color: Colors.green, fontSize: 14))
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}
