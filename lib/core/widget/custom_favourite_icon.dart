// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';

class CustomFavouriteIcon extends StatefulWidget {
  const CustomFavouriteIcon({
    super.key,
    required this.productId, required this.onChanged,
  });
  final String productId;
 final ValueChanged<bool> onChanged;

  @override
  State<CustomFavouriteIcon> createState() => _CustomFavouriteIconState();
}

class _CustomFavouriteIconState extends State<CustomFavouriteIcon> {
  @override
  void initState() {
    context.read<FavouriteCubit>().listenToFavorites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
      if (state is FavouriteFailure) {
        Warning.showWarning(context, message: state.errMessage);
      }
    }, builder: (context, state) {
      if (state is IsFavourite) {
        bool isFavourite = state.favProducts.contains(widget.productId);
        widget.onChanged(isFavourite);
    
        return Positioned(
            top: 10,
            left: 10,
            child: CustomCircleButton(
                icon: isFavourite
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
                      .addToFavorite(productId: widget.productId);
                }));
      }
      return Skeletonizer(
        enabled: true,
        child: CustomCircleButton(
            icon: const Icon(Icons.favorite_outline), funcation: () {}),
      );
    });
  }
}
