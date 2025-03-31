import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/see_all_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_advertise.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_category_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_explore_screen_search.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_new_arrivels_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_product_title_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomExploreScreenLoading extends StatelessWidget {
  const CustomExploreScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomExploreScreenSearch(),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: AppStyles.text18Regular,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40, child: CustomCategoryList()),
            const SizedBox(height: 10),
            // const CustomAdvertise(
            //   product: null,
            // ),
            CustomProductTitleSection(
              title: 'New Arrivals',
              funcation: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeeAllScreen(
                      products: [],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
                height: 200,
                child:  CustomHorzintalProductList(
                  products: [],
                )),
            CustomProductTitleSection(
              title: 'Popular Products',
              funcation: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeeAllScreen(
                      products: [],
                    ),
                  ),
                );
              },
            ),
            const CustomVerticalProductList(
              products: [],
            )
          ],
        ),
      ),
    );
  }
}
