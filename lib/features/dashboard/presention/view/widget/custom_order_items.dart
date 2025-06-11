import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_state.dart';
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
            onTap: () async{
              var product=await FirebaseFirestore.instance
                  .collection('products')
                  .doc(orderEntity.items[index].productId)
                  .get().then((value) => ProductModel.fromMap(value.data()!)) as ProductEntity;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardProductDetailsScreen( product: product,),
                ),
              );
            },
            child: ListTile(
              trailing: Text(
                '\$${orderEntity.items[index].productPrice*orderEntity.items[index].productQuantity}',
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
