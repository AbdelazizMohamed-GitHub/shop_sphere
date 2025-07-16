// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, 
    required this.products,
  });

  final List<ProductMostSellerModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قائمة المنتجات")),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
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
                "الكمية: ${product.productCount}\nالسعر: \$${product.productPrice.toStringAsFixed(2)}",
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
