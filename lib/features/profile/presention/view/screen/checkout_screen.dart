import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_button.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_listile.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_payment.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_get_location_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.total,
    required this.cartItems,
  });
  final double total;
  final List<CartItemModel> cartItems;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double shippingPrice = 0.0;
  @override
  void initState() {
    context.read<UserCubit>().getUserData();
    super.initState();
  }

  AddressModel addressEntity = AddressModel(
      id: '',
      phoneNumber: '',
      title: '',
      street: '',
      city: '',
      state: '',
      country: '',
      postalCode: '',
      createdAt: Timestamp.now());
  int paymentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                )),
        leadingWidth: 100,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFailure) {
            return CustomErrorWidget(
              errorMessage: state.errMessage,
              onpressed: () async {
                await context.read<UserCubit>().getUserData();
              },
            );
          } else if (state is UserSuccess) {
            return SingleChildScrollView(
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
                          CustomCheckoutListile(
                              title: state.user.email,
                              subtitle: "Email",
                              icon: const Icon(Icons.email_outlined,
                                  color: Colors.black),
                              isSelect: false),
                          CustomCheckoutListile(
                            title: state.user.phoneNumber,
                            subtitle: "Phone",
                            icon: const Icon(
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
                                  icon: const Icon(Icons.add),
                                  funcation: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddressScreen(
                                            selectAddressIndex:
                                                state.user.addressIndex,
                                          ),
                                        ));
                                  })
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomGetLocationWidget(
                            currentIndex: state.user.addressIndex,
                            onLocationSelected: (AddressModel value) {
                              setState(() {
                                addressEntity = value;
                              });
                              shippingPrice = AppFuncations.getShippingPrice(
                                  addressEntity.state);
                            },
                          ),
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
                          CustomCheckoutPayment(
                            onChanged: (value) {
                              setState(() {
                                paymentIndex = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomCartPrice(
                              title: 'Total:', price: widget.total.toDouble()),
                          CustomCartPrice(
                              title: 'Shipping:', price: shippingPrice),
                          const Divider(),
                          CustomCartPrice(
                              title: 'Total Cost:',
                              price: widget.total + 50,
                              isTotalcoast: true),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomCheckoutButton(
                            shippingCoast: shippingPrice.toInt(),
                            currentIndex: paymentIndex,
                            total: widget.total,
                            cartItems: widget.cartItems,
                            uId: state.user.uid,
                            userName: state.user.name,
                            address: addressEntity,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: Text("No Data"),
          );
        },
      ),
    );
  }
}
