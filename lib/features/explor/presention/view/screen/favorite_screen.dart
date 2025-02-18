import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          leading: CustomCircleButton(
              icon: const Icon(Icons.arrow_back_ios), funcation: () {
                  context.read<MainCubit>().changeScreenIndex(0);
              }),
          title: const Text('Favorite')),
      body: const SingleChildScrollView(child: CustomPopularProductList()),
    );
  }
}
