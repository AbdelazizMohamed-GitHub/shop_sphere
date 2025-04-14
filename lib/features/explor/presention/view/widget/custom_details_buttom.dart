import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_add_to_cart_button.dart';

class CustomDetailsButtom extends StatefulWidget {
  const CustomDetailsButtom({
    super.key,
    required this.productEntity,
   required this.isProductInCart ,
  
  });

  final ProductEntity productEntity;

 final  bool isProductInCart;

  @override
  State<CustomDetailsButtom> createState() => _CustomDetailsButtomState();
}

class _CustomDetailsButtomState extends State<CustomDetailsButtom> {
  int cartCount = 0;
   bool isInitialized=false;
   bool isProductInCart=false;
  // ✅ Track if cartCount was already set
// ✅ Set cartCount once when the product is in the cart and not yet initialized
                 @override
  void initState() {
    super.initState();
    isProductInCart = widget.isProductInCart;
   
    if (isProductInCart && !isInitialized) {
                    cartCount =
                        context.read<CartCubit>().cartEntity?.productQuantity ??
                            0;
                    isInitialized = true; // ✅ prevent future updates
                  }}
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
            child:
                  

                   Row(
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
          ))
        ,
              
          
          Expanded(
            child: CustomDetailsAddToCartButton(
              isProductInCart: widget.isProductInCart,
              cartCount: cartCount,
              productEntity: widget.productEntity,
            ),
         ),
        ],
      ),
    );
  }
}
