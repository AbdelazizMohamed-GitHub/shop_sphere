import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/loading/custom_icon_loading.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';

class CustomFavouriteIcon extends StatelessWidget {
  const CustomFavouriteIcon({
    super.key,
    required this.productId,
    required this.onChanged,
  });

  final String productId;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteFailure) {
          Warning.showWarning(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        bool isLoading = false;
        bool isFavourite = false;

        if (state is FavouriteUpdated) {
          isFavourite = state.favProducts.contains(productId);
          isLoading = state.loadingItems.contains(productId);
          onChanged(isFavourite);
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
                  funcation: () {
                    context
                        .read<FavouriteCubit>()
                        .toggleFavourite(productId: productId);
                  },
                ),
        );
      },
    );
  }
}
