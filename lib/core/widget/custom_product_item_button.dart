import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomProductItemButton extends StatefulWidget {
  const CustomProductItemButton({
    super.key,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  State<CustomProductItemButton> createState() =>
      _CustomProductItemButtonState();
}

class _CustomProductItemButtonState extends State<CustomProductItemButton> {
  @override
  void initState() {
    context.read<CartCubit>().listenIsProductInCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
      if (state is CartFailure) {
        Warning.showWarning(context, message: state.errMessage);
      }
    }, builder: (context, state) {
      if (state is CartLoading) {
        return _buildLoadingButton();
      }

      if (state is IsProductInCart) {
        bool isProductInCart =
            state.cartProduct.contains(widget.productEntity.id);

        return GestureDetector(
          onTap: () {
            if (isProductInCart) {
              context.read<CartCubit>().removeFromCart(
                    productId: widget.productEntity.id,
                  );
            } else {
              context.read<CartCubit>().addToCart(
                    cartItemModel: CartItemModel(
                      id: widget.productEntity.id,
                      name: widget.productEntity.name,
                      imageUrl: widget.productEntity.imageUrl,
                      price: widget.productEntity.price,
                      quantity: 1,
                    ),
                  );
            }
          },
          child: _buildCartButton(isProductInCart),
        );
      }

      return _buildLoadingButton(); // Default loading state
    });
  }

  Widget _buildCartButton(bool isProductInCart) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Icon(
        isProductInCart ? Icons.remove : Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildLoadingButton() {
    return Skeletonizer(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
