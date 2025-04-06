// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/utils/app_keys.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_done_screen.dart';
import 'package:uuid/uuid.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    Key? key,
    required this.currentIndex,
    required this.total,
    required this.cartItems,
    required this.uId,
    required this.address,
  }) : super(key: key);
  final int currentIndex;
  final double total;
  final List<CartItemModel> cartItems;
  final AddressModel address;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(orderRepo: getIt<OrderRepoImpl>()),
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            Warning.showWarning(context, message: state.error);
            print(state.error);
          } else if (state is AddOrderSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderDoneScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return state is OrderLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  onPressed: () async {
                    if (currentIndex == 0) {
                      var oId = const Uuid().v4();
                      OrderModel order = OrderModel(
                          uId: uId,
                          orderId: oId,
                          totalAmount: total + 50,
                          items: cartItems,
                          status: "Pending",
                          orderDate: Timestamp.now(),
                          address: address);

                      await context
                          .read<OrderCubit>()
                          .createOrder(order: order);

                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckoutView(
                          sandboxMode: true,
                          clientId: kClientId,
                          secretKey: kSecret,
                          transactions: const [
                            {
                              "amount": {
                                "total": '70',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '70',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Apple",
                                    "quantity": 4,
                                    "price": '5',
                                    "currency": "USD"
                                  },
                                  {
                                    "name": "Pineapple",
                                    "quantity": 5,
                                    "price": '10',
                                    "currency": "USD"
                                  }
                                ],
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderDoneScreen(),
                              ),
                            );
                          },
                          onError: (error) {
                            Warning.showWarning(
                              context,
                              message: error.toString(),
                            );
                          },
                          onCancel: () {
                            Warning.showWarning(context,
                                message: "The transaction has been cancelled");
                          },
                        ),
                      ));
                    }
                  },
                  text: currentIndex == 0
                      ? "Check Out"
                      : "Pay ${TestList.getTotalPrice() + 50}");
        },
      ),
    );
  }
}
