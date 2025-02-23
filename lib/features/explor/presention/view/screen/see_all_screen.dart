import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        leadingWidth: 100,
        title: const Text("See All"),
      ),
      body:const SingleChildScrollView(child: CustomPopularProductList()),
    );
  }
}
