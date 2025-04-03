import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/checkout_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_item_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartCubit(cartRepo: getIt<CartRepoImpl>())..getAllProductsInCart(),
      child: Scaffold(
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
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            }
            if (state is GetCartSuccess) {
              if (state.cartItems.isEmpty) {
                return const Center(
                  child: Text('Your cart is empty'),
                );
              }
            }
            if (state is GetCartSuccess) {
             
              return Column(
                children: [
                  Expanded(
                      child: CustomCartItemList(
                    cartItems: state.cartItems
                        .cast<CartEntity>(), // Cast to List<CartItemModel>
                  )),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      CustomCartPrice(
                          title: 'Total:', price: state.total.toDouble()),
                      const CustomCartPrice(title: 'Shipping:', price: 50),
                      const Divider(),
                      CustomCartPrice(
                          title: 'Total Cost:',
                          price: state.total + 50,
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
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }
}
