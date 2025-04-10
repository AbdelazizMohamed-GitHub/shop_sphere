import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_state.dart';

class CustomAdvertise extends StatelessWidget {
  const CustomAdvertise({super.key, required this.product});
  final ProductEntity? product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return CarouselSlider(
            items: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.isLightTheme(context)
                          ? Colors.white
                          : AppColors.secondaryDarkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                            imageUrl: product!.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CustomImageLoading(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error))),
                  ),
                  Positioned(
                    width: 120,
                    right: 40,
                    bottom: 40,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'offer 50%',
                        style: AppStyles.text22SemBoldWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
            ));
      },
    );
  }
}
