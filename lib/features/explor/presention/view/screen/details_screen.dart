import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_buttom.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_header.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.product,
    required this.isFaV,
  });
  final ProductEntity product;
  final bool isFaV;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomDetailsHeader(
                isFav: isFaV,
                product: product,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.name,
                      style: AppStyles.text26BoldBlack,
                    ),
                    Text(
                      '${product.price} \$',
                      style: AppStyles.text26BoldBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      '${product.description} ',
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
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          )),
      bottomNavigationBar: CustomDetailsButtom(
        productEntity: product,
      ),
    );
  }
}
