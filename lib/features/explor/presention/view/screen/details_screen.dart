import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import 'package:shop_sphere/core/loading/details_screen_loading.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_buttom.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_header.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen( {
    super.key,
    required this.product,
    required this.isFaV,
  });
  final ProductEntity product;
  final bool isFaV;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    context.read<CartCubit>().getProductInCart(productId: widget.product.pId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          Warning.showWarning(context, message: state.errMessage);
        }
        if (state is CartSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CartScreen();
          }));
        }
      },
      builder: (context, state) {
        if (state is CartFailure) {
          Warning.showWarning(context, message: state.errMessage);
        }
        if (state is CartLoading) {
          return const DetailsScreenLoading();
        }

        if (state is CartUpdated) {
          bool isProductInCart = state.cartProduct.contains(widget.product.pId);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    CustomDetailsHeader(
                      isFav: widget.isFaV,
                      product: widget.product,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 20),
                      child: ReadMoreText(
                        '${widget.product.description}  Perfumes vary in their compositions and longevity, ranging from highly concentrated perfumes (like "Parfum") to lighter fragrances (like "Eau de Cologne"). Each perfume is distinguished by its unique ingredients, which may be floral, woody, citrusy, or oriental, reflecting a distinctive character and personality for each wearer. 🌿✨',
                        style: const TextStyle(fontSize: 16),
                        trimMode: TrimMode.Length,
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
                )),
            bottomNavigationBar: CustomDetailsButtom(
              productEntity: widget.product,
              isProductInCart: isProductInCart,
            ),
          );
        }
        return const DetailsScreenLoading();
      },
    );
  }
}
