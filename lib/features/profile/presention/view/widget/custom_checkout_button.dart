import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/utils/app_keys.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_done_screen.dart';
import 'package:uuid/uuid.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.cartItems,
    required this.uId,
    required this.address,
    required this.userName,
    required this.shippingCoast,
  });
  final int currentIndex;
  final double total;
  final List<CartItemModel> cartItems;
  final AddressModel address;
  final String uId;
  final String userName;
  final int shippingCoast; // Replace with actual user name

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(orderRepo: getIt<OrderRepoImpl>()),
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            Warning.showWarning(context, message: state.error);
          } else if (state is CreateOrderSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderDoneScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return state is CreateOrderLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  onPressed: () async {
                    if (!await AppFuncations.isOnline()) {
                      Warning.showWarning(
                        context,
                        message: "No Internet Connection",
                        isError: true,
                      );
                      return;
                    }

                    if (address.state.isEmpty &&
                        address.city.isEmpty &&
                        address.street.isEmpty &&
                        address.phoneNumber.isEmpty) {
                      Warning.showWarning(context,
                          message: 'Please add address');
                    } else {
                      if (currentIndex == 0) {
                        var oId = const Uuid().v4();
                        OrderModel order = OrderModel(
                            userName: userName,
                            uId: uId,
                            orderId: oId,
                            totalAmount: total + shippingCoast,
                            items: cartItems,
                            status: "Pending",
                            orderDate: DateTime.now(),
                            address: address,
                            paymentMethod: "Cash on Delivery",
                            delivaryCoast: shippingCoast,
                            trackingNumber: 0);

                        await context
                            .read<OrderCubit>()
                            .createOrder(order: order);
                      } else {
                        final subtotal = cartItems.fold<double>(
                          0,
                          (sum, item) => sum + (item.price * item.quantity),
                        );


                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaypalCheckoutView(
                              sandboxMode: true,
                              clientId: AppKeys.kClientId,
                              secretKey: AppKeys.kSecret,
                              transactions: [
                                {
                                  "amount": {
                                    "total": (subtotal + shippingCoast)
                                        .toStringAsFixed(2),
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": subtotal.toStringAsFixed(2),
                                      "shipping":
                                          shippingCoast.toStringAsFixed(2),
                                      "shipping_discount": "0"
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": cartItems.map((item) {
                                      return {
                                        "name": item.name,
                                        "quantity": item.quantity,
                                        "price": item.price.toStringAsFixed(2),
                                        "currency": "USD"
                                      };
                                    }).toList(),
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                var oId = const Uuid().v4();
                                OrderModel order = OrderModel(
                                    userName: userName,
                                    uId: uId,
                                    orderId: oId,
                                    totalAmount: total + shippingCoast,
                                    items: cartItems,
                                    status: "Pending",
                                    orderDate: DateTime.now(),
                                    address: address,
                                    paymentMethod: "Paypal",
                                    delivaryCoast: shippingCoast,
                                    trackingNumber: 0);
                                await context
                                    .read<OrderCubit>()
                                    .createOrder(order: order);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderDoneScreen(),
                                  ),
                                );
                              },
                              onError: (error) {
                              
                                Warning.showWarning(
                                  context,
                                  message: 'Not Available in your Loction',
                                );
                              },
                              onCancel: () {
                                Warning.showWarning(context,
                                    message:
                                        "The transaction has been cancelled");
                              },
                            ),
                          ),
                        );
                      }
                    }
                  },
                  text: currentIndex == 0
                      ? "Check Out"
                      : "Pay ${total + shippingCoast} Egp",
                );
        },
      ),
    );
  }
}
