import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/utils/app_styles.dart';

class CustomOrderInformation extends StatelessWidget {
  const CustomOrderInformation({super.key, required this.order});
  final Map<String, dynamic> order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Information",
          style: AppStyles.text18Regular,
        ),
        const Divider(
          height: 20,
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Address",
              style: AppStyles.text16Regular,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                "Ahmed Hassan12 Tahrir Street, Apartment 5 Downtown Cairo, Cairo Governorate 11511  Egypt  +20 153019984  ",
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Method",
              style: AppStyles.text16Regular,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                "**** **** **** 1234",
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Cost",
              style: AppStyles.text16Regular,
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                "30 \$",
                style: AppStyles.text16Regular,
              ),
            )
          ],
        ),
        Row(
          children: [
            const Text(
              'Total Price ',
              style: AppStyles.text16Bold,
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              "${order['total'].toStringAsFixed(2)} \$",
              style: AppStyles.text16Bold,
            )
          ],
        ),
      ],
    );
  }
}
