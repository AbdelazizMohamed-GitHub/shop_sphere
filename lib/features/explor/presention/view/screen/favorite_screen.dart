import 'package:flutter/material.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: SingleChildScrollView(child: CustomPopularProductList()),
    );
  }
}
