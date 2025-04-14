import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class CustomOrderStutsList extends StatelessWidget {
  const CustomOrderStutsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: orderStauts.length,
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                context.read<OrderCubit>().changeOrderStatus(index);
                context.read<OrderCubit>().pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              },
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                margin: const EdgeInsets.only(right: 10),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: index == context.read<OrderCubit>().currentStatus
                      ? AppColors.primaryColor
                      : AppTheme.isLightTheme(context)
                          ? Colors.white
                          : AppColors.secondaryDarkColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Text(orderStauts[index],
                      style: index == context.read<OrderCubit>().currentStatus
                          ? AppStyles.text18RegularWhite
                          : AppStyles.text18Regular.copyWith(
                              color: AppTheme.isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                            )),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
