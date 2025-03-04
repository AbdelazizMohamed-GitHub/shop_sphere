import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/constant/screens_list.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class CustomOrderStutsList extends StatelessWidget {
  const CustomOrderStutsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: orderStauts.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                context.read<OrderCubit>().changeOrderStatus(index);
                context.read<OrderCubit>().pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              },
              child: AnimatedContainer(
                width: 100,
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: index == context.read<OrderCubit>().currentStatus
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Text(orderStauts[index],
                      style: index == context.read<OrderCubit>().currentStatus
                          ? AppStyles.text18RegularWhite
                          : AppStyles.text18RegularBlack),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
