// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

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
      appBar: AppBar(title: const Text("Most Sold Products")),
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
                ProductEntity product0 = await FirestoreService.getProduct(
                    productId: product.productId);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DashboardProductDetailsScreen(product: product0);
                }));
              },
              leading: Image.network(
                product.productImageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                product.productName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Count: ${product.productCount}\Price: \$${product.productPrice.toStringAsFixed(2)}",
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
