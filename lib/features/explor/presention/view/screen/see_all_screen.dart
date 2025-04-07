// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit(favouriteRepo: getIt<FavouriteRepoImpl>())
       ,
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          leadingWidth: 100,
          title: const Text("See All"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomVerticalProductList(
            products: products,
          ),
        )),
      ),
    );
  }
}
