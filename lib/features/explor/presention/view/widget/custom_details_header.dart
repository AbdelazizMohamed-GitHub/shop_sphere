import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_product_kind.dart';

class CustomDetailsHeader extends StatelessWidget {
  const CustomDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(children: [
        Positioned(
            top: 10,
            left: 50,
            right: -30,
            bottom: 0,
            child: Image.asset(AppImages.product)),
        Positioned(
          left: 20,
          right: 20,
          top: 50,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Product Name",
              style: AppStyles.text18RegularBlack
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Price",
              style: AppStyles.text18RegularBlack
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ]),
        ),
        const Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: SizedBox(height: 100, child: CustomProductKind()),
        )
      ]),
    );
  }
}
