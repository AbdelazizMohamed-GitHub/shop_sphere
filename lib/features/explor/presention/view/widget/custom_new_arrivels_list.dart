import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomNewArrivelsList extends StatelessWidget {
  const CustomNewArrivelsList({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                    ),
                    child:
                        SizedBox(width: 150, child: CustomProductItem(product: products[index],)),
                  );
                },
              );
  }
}