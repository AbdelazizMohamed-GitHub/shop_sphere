// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_favourite_icon.dart';
import 'package:shop_sphere/core/widget/custom_product_item_button.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({
    super.key,
    required this.product,
  });
  final ProductEntity product;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.isLightTheme(context)
            ? Colors.white
            : AppColors.secondaryDarkColor,
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
                              builder: (context) => DetailsScreen(
                                isFaV: isFav,
                                product: widget.product,
                              ),
                            ));
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.product.imageUrl,
                        placeholder: (context, url) => const Center(
                          child: CustomImageLoading(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.product.name,
                        style: AppStyles.text14Regular,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${widget.product.price.toStringAsFixed(1)}',
                            style: AppStyles.text16Regular),
                        const Spacer(),
                        Text(
                          widget.product.category,
                          style: AppStyles.text14Regular,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        widget.product.stock == 0
                            ? const Text('Out of Stock')
                            : Text(
                                '${widget.product.stock.toString()} Stock',
                              ),
                        const Spacer(),
                        CustomProductItemButton(productEntity: widget.product),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          CustomFavouriteIcon(
            productId: widget.product.pId,
            onChanged: (bool value) {
              isFav = value;
            },
          )
        ],
      ),
    );
  }
}
