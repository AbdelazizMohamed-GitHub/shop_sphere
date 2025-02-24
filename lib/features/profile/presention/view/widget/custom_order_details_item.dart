// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomOrderDetailsItem extends StatelessWidget {
  const CustomOrderDetailsItem({
    super.key,
    required this.item,
  });
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Image.asset(AppImages.product),
        title: Text(
          item['name'],
          style:
              AppStyles.text16BoldBlack.copyWith(fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          'Quantity: ${item['quantity']}',
          style: AppStyles.text14RegularBlack,
        ),
        trailing: Text('\$${item['price'].toStringAsFixed(2)}',
            style: AppStyles.text16BoldBlack),
      ),
    );
  }
}
