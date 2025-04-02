import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
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
                icon: const Icon(Icons.arrow_back_ios),
                funcation: () {
                  context.read<MainCubit>().changeScreenIndex(0);
                }),
            title: const Text('Favorite')),
        body: StreamBuilder(stream: getIt<FirestoreService>().getAllFavoriteProducts(), builder: (context, snapshot) {
        
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return CustomVerticalProductList(
              products: snapshot.data as List<ProductEntity>,
            );
        }
          return const Center(child: Text('No Data'));
        }));
}
}