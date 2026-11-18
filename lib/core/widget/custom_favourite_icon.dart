// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/loading/custom_icon_loading.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
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
    return BlocSelector<FavouriteCubit, FavouriteState,
        ({bool isLoading, bool isFavourite})>(
      selector: (state) {
        if (state is FavouriteUpdated) {
          return (
            isFavourite: state.favProducts.contains(productId),
            isLoading: state.loadingItems.contains(productId),
          );
        }
        return (isFavourite: false, isLoading: false);
      },
      builder: (context, data) {
        return Positioned(
          top: 10,
          left: 10,
          child: data.isLoading
              ? const CustomIconLoading()
              : CustomCircleButton(
                  icon: data.isFavourite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_outline),
                  funcation: () async {
                    bool isConnect = await AppFuncations.isOnline();

                    if (isConnect) {
                      await BlocProvider.of<FavouriteCubit>(context)
                          .toggleFavourite(productId: productId);
                    } else {
                      Warning.showWarning(
                        context,
                        message: 'No Internet Connection',
                        isError: true,
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}