import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_buttom.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_details_header.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
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
  double discountedPrice = 0;
  @override
  void initState() {
    discountedPrice = widget.product.price -
        (widget.product.price * widget.product.discount / 100);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.name,
                      style: AppStyles.text26BoldBlack,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${discountedPrice.toStringAsFixed(2)}', // السعر بعد الخصم
                          style: AppStyles.text22SemiBold, // أو أي ستايل تحبه
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}', // السعر القديم
                          style: AppStyles.text18Regular.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      '${widget.product.description} ',
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
        productEntity: widget.product,
      ),
    );
  }
}
