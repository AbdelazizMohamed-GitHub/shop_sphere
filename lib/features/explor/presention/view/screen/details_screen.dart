import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price - (product.price * product.discount / 100);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
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
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Stock & Staff
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("المخزون: ${product.stock}"),
                Text("بواسطة: ${product.staffName}"),
              ],
            ),
            const SizedBox(height: 24),

            // Button
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return CustomButton(
                    onPressed: () async {
                      if (state is CartUpdated &&
                          state.cartProduct.contains(product.pId)) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CartScreen();
                        }));
                      } else {
                        await context.read<CartCubit>().addToCart(
                              cartItemModel: CartItemModel(
                                id: product.pId,
                                name: product.name,
                                imageUrl: product.imageUrl,
                                price: discountedPrice,
                                quantity: 1,
                              ),
                            );
                      
                      }
                    },
                    text: state is CartLoading
                        ? "Loading..."
                        : state is CartUpdated &&
                                state.cartProduct.contains(product.pId)
                            ? "Go to Cart"
                            : "Add to Cart");
              },
            ),
          ],
        ),
      ),
    );
  }
}
