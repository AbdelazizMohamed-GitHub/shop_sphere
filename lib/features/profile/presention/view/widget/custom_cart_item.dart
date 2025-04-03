// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.item,
  });
  final CartEntity item;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Card(
          color: AppTheme.isLightTheme(context)
              ? Colors.white
              : AppColors.secondaryDarkColor,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: Container(
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.isLightTheme(context)
                    ? Colors.white
                    : AppColors.backgroundDarkColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item.productImage,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            title: Text(
              item.productName,
              style: AppStyles.text18Regular.copyWith(
                  color: AppTheme.isLightTheme(context)
                      ? Colors.black
                      : Colors.white),
            ),
            subtitle: Text(
                '\$${item.productPrice.toStringAsFixed(2)} x ${item.productQuantity}',
                style: AppStyles.text14Regular.copyWith(
                    color: AppTheme.isLightTheme(context)
                        ? Colors.black
                        : Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCircleButton(
                    icon: Icon(Icons.remove),
                    funcation: () async {
                      await context.read<CartCubit>().updateCartQuantity(
                          productId: item.productId, isIncrement: false);
                      context.read<CartCubit>().getAllProductsInCart();
                    }),
                const SizedBox(
                  width: 20,
                ),
                CustomCircleButton(
                    icon: const Icon(Icons.add),
                    funcation: () async {
                      await context.read<CartCubit>().updateCartQuantity(
                          productId: item.productId, isIncrement: true);
                      context.read<CartCubit>().getAllProductsInCart();
                    }),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                    onPressed: () async {
                      await context
                          .read<CartCubit>()
                          .removeFromCart(productId: item.productId);

                      context.read<CartCubit>().getAllProductsInCart();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
