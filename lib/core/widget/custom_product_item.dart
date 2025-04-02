import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_cubit.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomProductItem extends StatelessWidget {
  const CustomProductItem({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            FavouriteCubit(favouriteRepo: getIt<FavouriteRepoImpl>())
              ..isFavoriteExit(productId: product.id),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.isLightTheme(context)
                ? Colors.white
                : AppColors.secondaryDarkColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: product,
                                ),
                              ));
                        },
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            product.name,
                            style: AppStyles.text14Regular,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${product.price.toStringAsFixed(2)}',
                                style: AppStyles.text16Regular),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  return Positioned(
                      top: 10,
                      left: 10,
                      child: state is FavouriteLoading
                          ? Skeletonizer(
                              enabled: true,
                              child: CustomCircleButton(
                                  icon: Icon(Icons.favorite), funcation: () {}))
                          : state is IsFavourite
                              ? CustomCircleButton(
                                  icon: state.isFavourite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_outline,
                                        ),
                                  funcation: () async {
                                    await context
                                        .read<FavouriteCubit>()
                                        .addToFavorite(productId: product.id);

                                   
                                  })
                              : state is IsFavourite
                                  ? CustomCircleButton(
                                      icon: state.isFavourite
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_outline,
                                            ),
                                      funcation: () async {
                                        await context
                                            .read<FavouriteCubit>()
                                            .addToFavorite(
                                                productId: product.id);

                                        context
                                            .read<FavouriteCubit>()
                                            .isFavoriteExit(
                                                productId: product.id);
                                      })
                                  : Container());
                },
              )
            ],
          ),
        ));
  }
}
