import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/Custom_advertise.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_app_bar_cart.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_category_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_explore_screen_search.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_new_arrivels_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_product_title_section.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Explore',
          style: AppStyles.text26BoldBlack,
        ),
        actions: const [
          CustomAppBarCart(),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomExploreScreenSearch(),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: AppStyles.text18RegularBlack,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40, child: CustomCategoryList()),
            SizedBox(height: 10),
            CustomAdvertise(),
            CustomProductTitleSection(title: 'New Arrivals'),
            SizedBox(height: 200, child: CustomNewArrivelsList()),
            CustomProductTitleSection(title: 'Popular Products'),
            CustomPopularProductList()
          ],
        ),
      ),
    );
  }
}
