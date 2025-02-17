import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomDetailsButtom extends StatelessWidget {
  const CustomDetailsButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        )),
                    const Text(
                      '1',
                      style: AppStyles.text26BoldBlack,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ],
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
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
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add to cart',
                      style: AppStyles.text26BoldWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}