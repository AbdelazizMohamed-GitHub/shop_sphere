import 'package:flutter/material.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/checkout_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_item_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          title: const Text('My Cart'),
          leading: const CustomBackButton()),
      body: Column(
        children: [
          const Expanded(child: CustomCartItemList()),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              CustomCartPrice(title: 'Total:', price: TestList.getTotalPrice()),
              const CustomCartPrice(title: 'Shipping:', price: 50),
              const Divider(),
              CustomCartPrice(
                  title: 'Total Cost:',
                  price: TestList.getTotalPrice() + 50,
                  isTotalcoast: true),
              const SizedBox(height: 20.0),
              CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CheckoutScreen();
                    }));
                  },
                  text: "Checkout")
            ]),
          ),
        ],
      ),
    );
  }
}
