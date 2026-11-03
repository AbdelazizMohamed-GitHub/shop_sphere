import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class CustomOrderItemDashboard extends StatelessWidget {
  const CustomOrderItemDashboard({super.key, required this.orderEntity});
  final OrderEntity orderEntity;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orderEntity.items.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                AppRoute.productDetails,
                pathParameters: {
                  'productId': orderEntity.items[index].productId,
                },
              );
            },
            child: ListTile(
              trailing: Text(
                '\$${orderEntity.items[index].productPrice * orderEntity.items[index].productQuantity}',
                style: AppStyles.text18Regular,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Container(
                width: 70,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: CachedNetworkImage(
                  imageUrl: orderEntity.items[index].productImage,
                  placeholder: (context, url) =>
                      const Center(child: CustomImageLoading()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(orderEntity.items[index].productName,
                  style: AppStyles.text18Regular),
              subtitle: Text(
                '\$${orderEntity.items[index].productPrice.toStringAsFixed(2)} x ${orderEntity.items[index].productQuantity}',
              ),
            ),
          );
        },
      ),
    );
  }
}
