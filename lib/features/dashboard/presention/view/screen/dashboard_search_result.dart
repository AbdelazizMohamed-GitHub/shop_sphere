import 'package:flutter/material.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_gride.dart';

import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashboardSearchResult extends StatelessWidget {
  const DashboardSearchResult({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: SingleChildScrollView(child: CustomProductGrid(products: products,))
      
    );
  }
}
