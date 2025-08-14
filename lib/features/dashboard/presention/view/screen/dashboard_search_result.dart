import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
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
   final isDesktop = ResponsiveLayout.isDesktop(context);
    return Scaffold(
        appBar:isDesktop ? null : AppBar(
          title: const Text("Search Results"),
        ),
        body: SingleChildScrollView(
            child: CustomProductGrid(
          products: products,
        )));
  }
}
