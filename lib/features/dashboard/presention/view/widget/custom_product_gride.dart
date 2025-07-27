// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomProductGrid extends StatelessWidget {
  const CustomProductGrid({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    double padding = ResponsiveLayout.getHorizontalPadding(context);
    int crossCount = ResponsiveLayout.getCrossAxisCount(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 5 / 6,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomDashboardProductItem(product: products[index]);
      },
    );
  }
}
