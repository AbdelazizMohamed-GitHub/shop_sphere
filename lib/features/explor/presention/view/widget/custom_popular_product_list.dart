import 'package:flutter/material.dart';

import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomVerticalProductList extends StatelessWidget {
  const CustomVerticalProductList({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomProductItem(
          product: products[index],
        );
      },
    );
  }
}
