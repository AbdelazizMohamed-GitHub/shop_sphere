import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class CustomDetailsAddToCartButton extends StatelessWidget {
  const CustomDetailsAddToCartButton(
      {super.key, required this.cartCount, required this.productEntity});
  final int cartCount;
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is IsProductInCart) {
          bool isProductInCart = state.cartProduct.contains(productEntity.id);
          return GestureDetector(
            onTap: () async {
              if (isProductInCart) {
                await context.read<CartCubit>().updateCartQuantityWithCount(
                    productId: productEntity.id, count: cartCount);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CartScreen();
                }));
              } else {
                context.read<CartCubit>().addToCart(
                      cartItemModel: CartItemModel(
                        id: productEntity.id,
                        name: productEntity.name,
                        imageUrl: productEntity.imageUrl,
                        price: productEntity.price,
                        quantity: cartCount,
                      ),
                    );
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isProductInCart ? 'Go to cart' : 'Add to cart',
                    style: AppStyles.text26BoldWhite,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
