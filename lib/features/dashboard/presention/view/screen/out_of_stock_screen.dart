import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_gride.dart';

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
        appBar: AppBar(
          actions: [
            Text('${products.length} Products'),
            const SizedBox(
              width: 10,
            )
          ],
          title: const Text(
            " Out Of Stock  ",
            style: AppStyles.text18Regular,
          ),
        ),
        body: SingleChildScrollView(
            child: CustomProductGrid(products: products)));
  }
}
