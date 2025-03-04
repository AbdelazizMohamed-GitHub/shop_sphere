// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_images.dart';

import 'package:shop_sphere/core/utils/screens_list.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_state.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_listile.dart';

class CustomCheckoutPayment extends StatelessWidget {
  const CustomCheckoutPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutCubit, CheckOutState>(
      builder: (context, state) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: paymentMethod.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                context
                    .read<CheckOutCubit>()
                    .chnageCurrentPaymenMethodIndex(index);
              },
              child: CustomCheckoutListile(
                  isSelect:
                      context.read<CheckOutCubit>().currentPaymenMethodIndex ==
                          index,
                  title: paymentMethod[index].title,
                  subtitle: paymentMethod[index].title,
                  icon: Image.asset(
                    paymentMethod[index].imagePath,
                    fit: BoxFit.cover,
                  )),
            );
          },
        );
      },
    );
  }
}
