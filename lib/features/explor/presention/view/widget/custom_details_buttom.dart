// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class CustomDetailsButtom extends StatefulWidget {
  CustomDetailsButtom({
    Key? key,
    required this.cartCount,
    required this.productId,
  }) : super(key: key);
  int cartCount;
  final String productId;

  @override
  State<CustomDetailsButtom> createState() => _CustomDetailsButtomState();
}

class _CustomDetailsButtomState extends State<CustomDetailsButtom> {
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
              child: Row(
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
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => CartCubit(cartRepo: getIt<CartRepoImpl>()),
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      await context
                          .read<CartCubit>()
                          .updateCartQuantityWithCount(
                              productId: widget.productId,
                              count: widget.cartCount);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CartScreen();
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go to cart',
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
