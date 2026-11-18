import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/product_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';
import 'package:shop_sphere/features/main/presention/controller/main_cubit/main_cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Stream<List<ProductEntity>> _favoriteProductsStream;

  @override
  void initState() {
    super.initState();
    _favoriteProductsStream = _createFavoriteProductsStream();
  }

  Stream<List<ProductEntity>> _createFavoriteProductsStream() {
    return getIt<ProductService>().getAllFavoriteProducts();
  }

  void _retryFavoriteProducts() {
    setState(() {
      _favoriteProductsStream = _createFavoriteProductsStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 100,
            leading: IconButton(
                onPressed: () {
                  context.read<MainCubit>().changeScreenIndex(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                )),
            title: const Text('Favorite')),
        body: StreamBuilder(
            stream: _favoriteProductsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return CustomErrorWidget(
                  errorMessage: snapshot.error.toString(),
                  onpressed: _retryFavoriteProducts,
                );
              } else if (snapshot.hasData) {
                if ((snapshot.data as List<ProductEntity>).isEmpty) {
                  return const Center(
                      child: Text(
                    'No Favorites',
                    style: AppStyles.text22SemiBold,
                  ));
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomVerticalProductList(
                      products: snapshot.data as List<ProductEntity>,
                    ),
                  ),
                );
              }
              return const Center(child: Text('No Data'));
            }));
  }
}
