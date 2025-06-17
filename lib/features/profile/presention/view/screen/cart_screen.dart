import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/checkout_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_item_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text('My Cart'),
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart")
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return  CustomErrorWidget(
                errorMessage: snapshot.error.toString(),
                onpressed: () {
                  setState(() {
                    
                  });
                },
              );
            } else if (snapshot.hasData) {
              List<CartItemModel> cartItems = snapshot.data!.docs.map((doc) {
                return CartItemModel.fromMap(doc.data());
              }).toList();
              if (cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              } else {
                // Calculate the total cost
                int totalQuantity = 0;
                for (var item in cartItems) {
                  totalQuantity += item.productQuantity;
                }
                double total = 0.0;
                for (var item in cartItems) {
                  total += item.productPrice * item.productQuantity;
                }
                return Column(
                  children: [
                    Expanded(child: CustomCartItemList(cartItems: cartItems)),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Quntity : ",
                              style: AppStyles.text18Regular,
                            ),
                            Text(
                              totalQuantity.toString(),
                              style: AppStyles.text22SemiBold,
                            )
                          ],
                        ),
                        const Divider(),
                        CustomCartPrice(
                            title: ' Cost:', price: total, isTotalcoast: true),
                        const SizedBox(height: 20.0),
                        CustomButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CheckoutScreen(
                                  total: total,
                                  cartItems: cartItems,
                                );
                              }));
                            },
                            text: "Checkout")
                      ]),
                    ),
                  ],
                );
              }
            }
            return const Center(child: Text('No Data'));
          }),
    );
  }
}
