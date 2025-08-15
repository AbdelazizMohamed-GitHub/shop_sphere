import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomDashboardProductItem extends StatelessWidget {
  const CustomDashboardProductItem({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoute.productDetails,
          pathParameters: {'productId': product.pId},
          extra: product, // دي بس لو المستخدم جاي من نفس الجلسة
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CustomImageLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: AppStyles.text14Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$ ${product.price}', style: AppStyles.text16Bold),
                      const Spacer(),
                      Text(
                        '${product.stock} Stock',
                        style: AppStyles.text14Regular,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Add By ',
                    style: AppStyles.text16Regular,
                  ),
                  Text(
                    maxLines: 1,
                    product.staffName,
                    overflow: TextOverflow.fade,
                    style: AppStyles.text14Regular,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
