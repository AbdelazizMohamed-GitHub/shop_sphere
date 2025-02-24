import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';

class CustomProductItem extends StatelessWidget {
  const CustomProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailsScreen(),
                          ));
                    },
                    child: Image.asset(
                      AppImages.product,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product 1',
                      style: AppStyles.text18RegularBlack,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '\$100',
                          style: AppStyles.text18RegularBlack,
                        ),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CustomCircleButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                funcation: () {}),
          )
        ],
      ),
    );
  }
}
