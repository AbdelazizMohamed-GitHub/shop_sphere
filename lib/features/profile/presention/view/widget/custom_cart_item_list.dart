import 'package:flutter/material.dart';

import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_item.dart';

class CustomCartItemList extends StatelessWidget {
  const CustomCartItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: TestList.cartItems.length,
      itemBuilder: (context, index) {
        final item = TestList.cartItems[index];
        return CustomCartItem(item: item);
      },
    );
  }
}
