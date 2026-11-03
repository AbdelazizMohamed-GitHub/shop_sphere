import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
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
            CustomProductTitleSection(
              title: 'New Arrivals',
              funcation: () {
                context.pushNamed(AppRoute.seeAll, extra: <ProductEntity>[]);
              },
            ),
            const SizedBox(
                height: 200,
                child: CustomHorzintalProductList(
                  products: [],
                )),
            CustomProductTitleSection(
              title: 'Popular Products',
              funcation: () {
                context.pushNamed(AppRoute.seeAll, extra: <ProductEntity>[]);
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
