import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/details_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';


class CustomDashboardProductItem extends StatelessWidget {
  const CustomDashboardProductItem({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashBoardDetailsScreen(product: product);
                        },
                      ),
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
                child: GestureDetector(
                 
                  onTap: () {
                  
                  },
                  child: CachedNetworkImage(imageUrl: product.imageUrl, fit: BoxFit.cover,placeholder: (context, url) => const CustomImageLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(product.name, style: AppStyles.text14Regular),
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
