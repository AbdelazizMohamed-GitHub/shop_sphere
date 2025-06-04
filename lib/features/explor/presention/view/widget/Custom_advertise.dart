import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';

class CustomAdvertise extends StatelessWidget {
  const CustomAdvertise({super.key, required this.product});
  final List<ProductEntity> product;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
            items: product.take(4)
                .map((item) =>Stack(
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
                            imageUrl: item.imageUrl,
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return  ProductDetailsScreen(product: item,);
                        }));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Text(
                          '${item.discount}% off',
                          style: AppStyles.text22SemBoldWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
                .toList(),
            options: CarouselOptions(
              
              autoPlay: true,
              height: 200,
            ));
      }
   
}
