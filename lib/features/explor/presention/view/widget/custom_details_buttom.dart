import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
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

  bool isProductInCart= false;
int cartCount = 0;
bool updateCount=true;
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getProductInCart(productId: widget.productEntity.pId);();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          Warning.showWarning(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartUpdated) {
          print(cartCount);
          isProductInCart =
              state.cartProduct.contains(widget.productEntity.pId);
 if (isProductInCart && updateCount) {
          cartCount =
              context.read<CartCubit>().cartEntity?.productQuantity ?? 0;
          updateCount = false; // ✅ prevent future updates
        // ✅ prevent future updates
        }
         
        }
       
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: ()async {
                        if (cartCount == 0) return;
                                                cartCount--;

                         await context.read<CartCubit>().updateCartQuantityWithCount(
                    productId: widget.productEntity.pId, count: cartCount);
                        
                      },
                      icon: const Icon(Icons.remove, size: 30),
                    ),
                    Text(
                      cartCount.toString(),
                      style: AppStyles.text26BoldBlack,
                    ),
                    IconButton(
                      onPressed: () async{
                        if (cartCount == 10) return;
                        cartCount++;
                      await  context.read<CartCubit>().updateCartQuantityWithCount(
                            productId: widget.productEntity.pId,
                            count: cartCount);
                       
                      },
                      icon: const Icon(Icons.add, size: 30),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomDetailsAddToCartButton(
                  isProductInCart: isProductInCart ?? false,
                  cartCount: cartCount,
                  productEntity: widget.productEntity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
