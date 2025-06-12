// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class OutOfStockScreen extends StatelessWidget {
  const OutOfStockScreen({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Out Of Stock ${products.length}",style: AppStyles.text18Regular,),
      ),
    );
  }
}
