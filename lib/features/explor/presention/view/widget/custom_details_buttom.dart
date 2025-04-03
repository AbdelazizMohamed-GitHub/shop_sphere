// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class CustomDetailsButtom extends StatefulWidget {
   CustomDetailsButtom({
    Key? key,
    required this.cartCount,
  }) : super(key: key);
   int cartCount;

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
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
            ),
          ),
        ],
      ),
    );
  }
}
