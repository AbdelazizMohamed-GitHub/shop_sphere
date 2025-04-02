import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomProductItemLoading extends StatelessWidget {
  const CustomProductItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: true,
      child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
    );
  }
}