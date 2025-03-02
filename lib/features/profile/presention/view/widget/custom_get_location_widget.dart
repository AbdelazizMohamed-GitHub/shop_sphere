import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';

class CustomGetLocationWidget extends StatelessWidget {
  const CustomGetLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return               Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 180,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.map,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withValues(alpha: 0.5)),
                        ),
                        CustomCircleButton(
                            icon: const Icon(
                              Icons.location_on,
                              color: AppColors.primaryColor,
                            ),
                            funcation: () {})
                      ],
                    );
  }
}