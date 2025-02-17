import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';

class CustomNewArrivelsList extends StatelessWidget {
  const CustomNewArrivelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                    ),
                    child:
                        SizedBox(width: 150, child: CustomProductItem()),
                  );
                },
              );
  }
}