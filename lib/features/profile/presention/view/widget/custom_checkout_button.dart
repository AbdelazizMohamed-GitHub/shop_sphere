// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_state.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: () {},
        text: currentIndex == 0
            ? "Check Out"
            : "Pay ${TestList.getTotalPrice() + 50}");
  }
}
