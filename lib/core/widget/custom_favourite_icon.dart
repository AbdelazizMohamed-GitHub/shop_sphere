// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';

class CustomFavouriteIcon extends StatelessWidget {
  const CustomFavouriteIcon({
    super.key,
    required this.productId,
  });
  final String productId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        return Positioned(
          top: 10,
          left: 10,
          child: state is FavouriteLoading
              ? Skeletonizer(
                  enabled: true,
                  child: CustomCircleButton(
                      icon:const Icon(Icons.favorite), funcation: () {}))
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
                            .addToFavorite(productId: productId);
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
                                .addToFavorite(productId: productId);
                          },
                        )
                      : Container(),
        );
      },
    );
  }
}
