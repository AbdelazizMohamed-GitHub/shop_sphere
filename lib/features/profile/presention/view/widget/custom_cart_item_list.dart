import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/widget/warning.dart';

import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_item.dart';

class CustomCartItemList extends StatelessWidget {
  const CustomCartItemList({super.key, required this.cartItems});
  final List<CartEntity> cartItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CustomCartItem(item: cartItems[index]);
      },
    );
  }
}
