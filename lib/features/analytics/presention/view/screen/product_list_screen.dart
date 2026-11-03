// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    super.key,
    required this.products,
  });

  final List<ProductMostSellerModel> products;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = ResponsiveLayout.getHorizontalLargePadding(
        context); // 5% of screen width
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Most Sold Products"),
      ),
      body: ListView.separated(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: ListTile(
              onTap: () async {
                context.pushNamed(
                  AppRoute.productDetails,
                  pathParameters: {
                    'productId': product.productId,
                  },
                );
              },
              leading: SizedBox(height: 60,width: 60,
                child: CachedNetworkImage(
                  imageUrl: product.productImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CustomImageLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(
                product.productName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Count: ${product.productCount}   Price:${product.productPrice.toStringAsFixed(2)} EGP",
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
