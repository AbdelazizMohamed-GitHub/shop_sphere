import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/test/test_list.dart';

class CustomCartItemList extends StatelessWidget {
  const CustomCartItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              itemCount: TestList.cartItems.length,
              itemBuilder: (context, index) {
                final item = TestList.cartItems[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(
                        AppImages.product,
                        width: 60,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: AppStyles.text18RegularBlack,
                    ),
                    subtitle: Text(
                        '\$${item['price'].toStringAsFixed(2)} x ${item['quantity']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            );
  }
}