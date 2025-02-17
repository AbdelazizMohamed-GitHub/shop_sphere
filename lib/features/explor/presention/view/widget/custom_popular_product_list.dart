import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';

class CustomPopularProductList extends StatelessWidget {
  const CustomPopularProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomProductItem();
              },
            );
  }
}