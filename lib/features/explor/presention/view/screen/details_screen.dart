import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_buttom.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_header.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                CustomDetailsHeader(
                  product: product,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: ReadMoreText(
                    '${product.description}  Perfumes vary in their compositions and longevity, ranging from highly concentrated perfumes (like "Parfum") to lighter fragrances (like "Eau de Cologne"). Each perfume is distinguished by its unique ingredients, which may be floral, woody, citrusy, or oriental, reflecting a distinctive character and personality for each wearer. 🌿✨',
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
                // CustomProductTitleSection(
                //   title: 'Related Products',
                //   funcation: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SeeAllScreen(
                //           products: products,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                const SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //     height: 200,
                //     child: CustomHorzintalProductList(
                //       products: products,
                //     ))
              ]),
            )),
        bottomNavigationBar: const CustomDetailsButtom());
  }
}
