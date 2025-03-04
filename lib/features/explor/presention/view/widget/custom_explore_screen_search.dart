import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class CustomExploreScreenSearch extends StatelessWidget {
  const CustomExploreScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextForm(
                        pIcon: Icons.search,
                        text: 'Looking for something?',
                        kType: TextInputType.text),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(AppImages.filter, width: 30, height: 30),
                  ),
                ],
              ),
            );
  }
}