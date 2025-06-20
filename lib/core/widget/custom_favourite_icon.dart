import 'dart:math';

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
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoading = false;
        bool isFavourite = false;

        if (state is FavouriteUpdated) {
          isFavourite = state.favProducts.contains(productId);
          isLoading = state.loadingItems.contains(productId);
        }

        return Positioned(
          top: 10,
          left: 10,
          child: isLoading
              ? const CustomIconLoading()
              : CustomCircleButton(
                  icon: isFavourite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_outline),
                  funcation: () async {
                 bool isConnect=   await AppFuncations.isOnline();
               
                    if (isConnect) {
                      await  context
                          .read<FavouriteCubit>()
                          .toggleFavourite(productId: productId);
                    }
                     else {
                        Warning.showWarning(context,
                          message: 'No Internet Connection', isError: true);
                      return;
                     }

                  
                  },
                ),
        );
      },
    );
  }
}
