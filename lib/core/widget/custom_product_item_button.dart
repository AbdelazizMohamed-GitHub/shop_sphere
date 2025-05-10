import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/loading/custom_cart_button_loading.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CustomProductItemButton extends StatelessWidget {
  const CustomProductItemButton({
    super.key,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      bool isProductInCart = false;
      bool isLoading = false;
      if (state is CartUpdated) {
        isProductInCart = state.cartProduct.contains(productEntity.pId);
        isLoading = state.loadingItems.contains(productEntity.pId);
      }
      return isLoading
          ? const CustomCartButtonLoading()
          : GestureDetector(
              onTap: () async {
              isProductInCart?null:  await context.read<CartCubit>().addToCart(
                      cartItemModel: CartItemModel(
                        id: productEntity.pId,
                        name: productEntity.name,
                        imageUrl: productEntity.imageUrl,
                        price: productEntity.price,
                        quantity: 1,
                      ),
                    );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Icon(
                  isProductInCart ? Icons.add : Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ));
    });
  }
}
