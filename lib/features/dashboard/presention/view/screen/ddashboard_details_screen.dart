import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashboardProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const DashboardProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price - (product.price * product.discount / 100);

    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomCircleButton(
              icon: const Icon(Icons.edit, size: 25),
              funcation: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddProductScreen(
                        isUpdate: true,
                        productEntity: product,
                      );
                    },
                  ),
                );
              }),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text(
          'Details',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Name + Category
            Text(product.name,
                style: Theme.of(context).textTheme.headlineSmall),
            Text("Category: ${product.category}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            // Price
            Row(
              children: [
                if (product.discount > 0)
                  Text(
                    "${product.price.toStringAsFixed(2)} EGP",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  "${discountedPrice.toStringAsFixed(2)} EGP",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (product.discount > 0)
                  Text(
                    " (${product.discount}%)",
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Stock & Staff
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Stock: ${product.stock}", style: AppStyles.text18Regular),
                Text("Staff: ${product.staffName}",
                    style: AppStyles.text18Regular),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
