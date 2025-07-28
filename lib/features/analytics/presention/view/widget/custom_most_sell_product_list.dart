import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class CustomMostSellProductList extends StatelessWidget {
  const CustomMostSellProductList({super.key, required this.products});
final List<ProductMostSellerModel> products;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final color =
                    AppFuncations.getColorForProduct(product.productName);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                    Text(
                      '${product.productName} (${product.productCount})',
                      style: AppStyles.text14Regular,
                    ),
                  ],
                );
              },
            );
  }
}