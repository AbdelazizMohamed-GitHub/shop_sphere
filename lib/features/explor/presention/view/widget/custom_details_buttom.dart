import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/loading/details_screen_loading.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_add_to_cart_button.dart';

class CustomDetailsButtom extends StatefulWidget {
  const CustomDetailsButtom({
    super.key,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  State<CustomDetailsButtom> createState() => _CustomDetailsButtomState();
}

class _CustomDetailsButtomState extends State<CustomDetailsButtom> {
  int cartCount = 0;
  bool _isInitialized = false; // ✅ Track if cartCount was already set

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartFailure) {
                  return Center(
                    child: Text('Error loading cart ${state.errMessage}'),
                  );
                } else if (state is IsProductInCart) {
                  bool isProductInCart =
                      state.cartProduct.contains(widget.productEntity.id);

                  // ✅ Set cartCount once when the product is in the cart and not yet initialized
                  if (isProductInCart && !_isInitialized) {
                    cartCount =
                        context.read<CartCubit>().cartEntity?.productQuantity ?? 0;
                    _isInitialized = true; // ✅ prevent future updates
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (cartCount == 0) return;
                          setState(() {
                            cartCount--;
                          });
                        },
                        icon: const Icon(Icons.remove, size: 30),
                      ),
                      Text(
                        cartCount.toString(),
                        style: AppStyles.text26BoldBlack,
                      ),
                      IconButton(
                        onPressed: () {
                          if (cartCount == 10) return;
                          setState(() {
                            cartCount++;
                          });
                        },
                        icon: const Icon(Icons.add, size: 30),
                      ),
                    ],
                  );
                }
                return const DetailsScreenLoading();
              },
            ),
          ),
          Expanded(
            child: CustomDetailsAddToCartButton(
              cartCount: cartCount,
              productEntity: widget.productEntity,
            ),
          ),
        ],
      ),
    );
  }
}
