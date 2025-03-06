// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/utils/app_keys.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_done_screen.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: () {
          currentIndex == 0
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDoneScreen(),
                  ),
                )
              : Navigator.of(context).push(MaterialPageRoute(
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
                        "description": "The payment transaction description.",
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
        },
        text: currentIndex == 0
            ? "Check Out"
            : "Pay ${TestList.getTotalPrice() + 50}");
  }
}
