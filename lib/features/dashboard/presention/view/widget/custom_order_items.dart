import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/process_order_screen.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({super.key, required this.orderEntity});
  final OrderEntity orderEntity;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return  ProcessOrderScreen(
                order: orderEntity,
              );
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: orderEntity.items.length,

          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image.asset(
                  AppImages.product,
                  width: 60,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(orderEntity.items[index].productName, style: AppStyles.text18Regular),
              subtitle: Text(
                '\$${orderEntity.items[index].productPrice.toStringAsFixed(2)} x ${orderEntity.items[index].productQuantity}',
              ),
            );
          },
        ),
      ),
    );
  }
}
