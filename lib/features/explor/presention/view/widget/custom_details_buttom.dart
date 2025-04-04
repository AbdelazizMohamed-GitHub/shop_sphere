// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class CustomDetailsButtom extends StatefulWidget {
  CustomDetailsButtom({
    Key? key,
    required this.cartCount,
    required this.productEntity,
  }) : super(key: key);
  int cartCount;
  final ProductEntity productEntity;

  @override
  State<CustomDetailsButtom> createState() => _CustomDetailsButtomState();
}

class _CustomDetailsButtomState extends State<CustomDetailsButtom> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartCubit(cartRepo: getIt<CartRepoImpl>())
          ..listenIsProductInCart()
          ..getProductInCart(productId: '42b0e7f5-f1db-46b6-8191-780b0aa5ab0b'),
        child: Padding(
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
                      if (state is CartLoading) {
                        return Center(
                          child: const CircularProgressIndicator(),
                        );
                      } else if (state is CartFailure) {
                        return Center(
                          child: Text('Error loading cart ${state.errMessage}'),
                        );
                      } else if (state is GetProductInCart) {
                        int count = state.cartProduct.productQuantity;
                        widget.cartCount = count;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (widget.cartCount == 0) return;
                                setState(() {
                                  widget.cartCount--;
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 30,
                              )),
                          Text(
                            widget.cartCount.toString(),
                            style: AppStyles.text26BoldBlack,
                          ),
                          IconButton(
                              onPressed: () {
                                if (widget.cartCount == 10) return;
                                setState(() {
                                  widget.cartCount++;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              )),
                        ],
                      );
                    },
                  )),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                   if (state is CartFailure) {
                      return Center(
                        child: Text('Error loading cart ${state.errMessage}'),
                      );
                    } else if (state is IsProductInCart) {
                      bool isProductInCart =
                          state.cartProduct.contains(widget.productEntity.id);
                      return GestureDetector(
                        onTap: () async {
                          if (isProductInCart) {
                            await context
                                .read<CartCubit>()
                                .updateCartQuantityWithCount(
                                    productId: widget.productEntity.id,
                                    count: widget.cartCount);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CartScreen();
                            }));
                          } else {
                            context.read<CartCubit>().addToCart(
                                  cartItemModel: CartItemModel(
                                    id: widget.productEntity.id,
                                    name: widget.productEntity.name,
                                    imageUrl: widget.productEntity.imageUrl,
                                    price: widget.productEntity.price,
                                    quantity: widget.cartCount,
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
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
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
                ),
              ),
            ],
          ),
        ));
  }
}
