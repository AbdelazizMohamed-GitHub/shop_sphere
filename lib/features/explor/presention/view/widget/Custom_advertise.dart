import 'package:carousel_slider/carousel_slider.dart' show CarouselOptions, CarouselSlider;
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomAdvertise extends StatelessWidget {
  const CustomAdvertise({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
                items: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(AppImages.product, fit: BoxFit.fill),
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
  }
}