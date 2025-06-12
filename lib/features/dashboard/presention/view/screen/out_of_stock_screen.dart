// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';

import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class OutOfStockScreen extends StatelessWidget {
  const OutOfStockScreen({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Text('${products.length} Products'),const SizedBox(width: 10,)],
        title: const Text(
          " Out Of Stock  ",
          style: AppStyles.text18Regular,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 5 / 6,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomDashboardProductItem(product: products[index]);
        },
      ),
    );
  }
}
