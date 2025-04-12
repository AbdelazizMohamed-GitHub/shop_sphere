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
    required this.productId,
    required this.onChanged,
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
      },
      builder: (context, state) {
        final cubit = context.read<FavouriteCubit>();

        bool isFavourite = false;
        bool isLoading = false;

        if (state is IsFavourite) {
          isFavourite = state.favProducts.contains(widget.productId);
          widget.onChanged(isFavourite);
        }

        if (state is FavouriteLoadingItem &&
            state.productId == widget.productId) {
          isLoading = true; // 👈 Only mark this item as loading
        }

        return Positioned(
          top: 10,
          left: 10,
          child: isLoading
              ? const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : CustomCircleButton(
                  icon: isFavourite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_outline),
                  funcation: () async{
                  await  context.read<FavouriteCubit>().addToFavorite(
                          productId: widget.productId,
                        );
                        
                  },
                ),
        );
      },
    );
  }
}
