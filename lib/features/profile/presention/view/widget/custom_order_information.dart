import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class CustomOrderInformation extends StatelessWidget {
  const CustomOrderInformation({super.key, required this.order});
  final OrderEntity order;
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const  Text(
              "Shipping Address",
              style: AppStyles.text16Regular,
            ),
           const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                "${order.address.city}, ${order.address.street}, ${order.address.state}",
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
                "Pay on Delivery",
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
              "${order.totalAmount} \$",
              style: AppStyles.text16Bold,
            )
          ],
        ),
      ],
    );
  }
}
