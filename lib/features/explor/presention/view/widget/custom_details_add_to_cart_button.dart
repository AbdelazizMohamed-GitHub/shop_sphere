import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
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
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          Warning.showWarning(context, message: state.errMessage);
        }

        if (state is CartSuccess) {
         
        }
      },
      builder: (context, state) {
        if (state is IsProductInCart) {
          bool isProductInCart = state.cartProduct.contains(productEntity.pId);
          return GestureDetector(
            onTap: () async {
              if (isProductInCart) {
                await context.read<CartCubit>().updateCartQuantityWithCount(
                    productId: productEntity.pId, count: cartCount);

                     // ignore: use_build_context_synchronously
                     Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CartScreen();
          }));
              } else {
                await context.read<CartCubit>().addToCart(
                      cartItemModel: CartItemModel(
                        id: productEntity.pId,
                        name: productEntity.name,
                        imageUrl: productEntity.imageUrl,
                        price: productEntity.price,
                        quantity: 1,
                      ),
                    );
                // ignore: use_build_context_synchronously
                context
                    .read<CartCubit>()
                    .getProductInCart(productId: productEntity.pId);
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
