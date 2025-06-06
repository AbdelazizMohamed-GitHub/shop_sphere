import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomDetailsHeader extends StatelessWidget {
  const CustomDetailsHeader({
    super.key,
    required this.product,
    required this.isFav,
  });
  final ProductEntity product;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(children: [
        Positioned(
            top: 50,
            left: 5,
            right: 10,
            bottom: 0,
            child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error))),
        Positioned(
          left: 20,
          right: 20,
          top: 50,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleButton(
                      icon: const Icon(Icons.arrow_back),
                      funcation: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomCircleButton(
                      icon: isFav
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border),
                      funcation: () {},
                    ),
                  ],
                ),
              ]),
        ),
      
        // const Positioned(
        //   bottom: 10,
        //   left: 0,
        //   right: 0,
        //   child: SizedBox(height: 100, child: CustomProductKind()),
        // )
      ]),
    );
  }
}
