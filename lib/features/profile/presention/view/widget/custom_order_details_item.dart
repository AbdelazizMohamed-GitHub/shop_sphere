// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';

import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

class CustomOrderDetailsItem extends StatelessWidget {
  const CustomOrderDetailsItem({
    super.key,
    required this.item,
  });
  final CartEntity item;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.isLightTheme(context)
          ? Colors.white
          : AppColors.secondaryDarkColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Image.asset(AppImages.product),
        title: Text(
          item.productName,
          style: AppStyles.text16Bold,
        ),
        subtitle: Text(
          'Quantity: ${item.productQuantity}',
          style: AppStyles.text14Regular,
        ),
        trailing: Text('\$${item.productPrice.toStringAsFixed(2)}',
            style: AppStyles.text16Bold),
      ),
    );
  }
}
