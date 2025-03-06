import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';

import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_state.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_button.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_listile.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_payment.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_get_location_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckOutCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          leading: AppTheme.isLightTheme(context)
              ? const CustomBackButton()
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  )),
          leadingWidth: 100,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: AppTheme.isLightTheme(context)
                    ? Colors.white
                    : AppColors.backgroundDarkColor,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact Information",
                        style: AppStyles.text18Regular,
                      ),
                      const CustomCheckoutListile(
                          title: "abdelaziz@gmail.com",
                          subtitle: "Email",
                          icon: Icon(Icons.email_outlined, color: Colors.black),
                          isSelect: false),
                      const CustomCheckoutListile(
                        title: "01153019984",
                        subtitle: "Phone",
                        icon: Icon(
                          Icons.phone_outlined,
                          color: Colors.black,
                        ),
                        isSelect: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Address",
                            style: AppStyles.text18Regular,
                          ),
                          CustomCircleButton(
                              icon: const Icon(Icons.add), funcation: () {})
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomGetLocationWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Payment Method",
                        style: AppStyles.text18Regular,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomCheckoutPayment(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomCartPrice(
                          title: 'Total:', price: TestList.getTotalPrice()),
                      const CustomCartPrice(title: 'Shipping:', price: 50),
                      const Divider(),
                      CustomCartPrice(
                          title: 'Total Cost:',
                          price: TestList.getTotalPrice() + 50,
                          isTotalcoast: true),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CheckOutCubit, CheckOutState>(
                        builder: (context, state) {
                          return CustomCheckoutButton(
                              currentIndex: context
                                  .read<CheckOutCubit>()
                                  .currentPaymenMethodIndex);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
