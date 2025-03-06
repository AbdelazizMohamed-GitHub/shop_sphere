import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 100,
            leading: CustomCircleButton(
                icon: const Icon(Icons.arrow_back_ios),
                funcation: () {
                  context.read<MainCubit>().changeScreenIndex(0);
                }),
            title: const Text('Favorite')),
        body: const Center(
            child: Icon(
          Icons.favorite_rounded,
          color: AppColors.primaryColor,
          size: 100,
        ))
        // const SingleChildScrollView(child: CustomPopularProductList(products: [],)),
        );
  }
}
