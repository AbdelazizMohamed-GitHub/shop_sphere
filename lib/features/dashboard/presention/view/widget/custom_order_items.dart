import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/utils/app_images.dart';
import 'package:shop_sphere_dashboard/core/utils/app_styles.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/process_order_screen.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({super.key, required this.item});
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProcessOrderScreen();
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 2,

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
              title: Text(item['name'], style: AppStyles.text18Regular),
              subtitle: Text(
                '\$${item['price'].toStringAsFixed(2)} x ${item['quantity']}',
              ),
            );
          },
        ),
      ),
    );
  }
}
