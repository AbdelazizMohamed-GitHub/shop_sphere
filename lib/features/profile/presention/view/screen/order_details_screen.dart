import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/funcation/order_funcation.dart';
import 'package:shop_sphere/core/test/test_list.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading:const CustomBackButton(),
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Order ID: ${order['id']}',
                  style: AppStyles.text18RegularBlack,
                ),
                const Spacer(),
                Text(
                  '${order["date"]}',
                  style: AppStyles.text14RegularBlack,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Tracking Number: 1234567890'),
                const Spacer(),
                Text(
                  ' ${order['status']}',
                  style: TextStyle(
                      fontSize: 16,
                      color: OrderFuncation.getStatusColor(order['status'])),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '${TestList.order["items"].length} Items:',
              style: AppStyles.text18RegularBlack,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: Image.asset(AppImages.product),
                    title: Text(
                      item['name'],
                      style: AppStyles.text16BoldBlack
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      'Quantity: ${item['quantity']}',
                      style: AppStyles.text14RegularBlack,
                    ),
                    trailing: Text('\$${item['price'].toStringAsFixed(2)}',
                        style: AppStyles.text16BoldBlack),
                  );
                },
              ),
            ),
            const Text(
              "Order Information",
              style: AppStyles.text16BoldBlack,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shipping Address",
                  style: AppStyles.text16RegularBlack,
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
                  style: AppStyles.text16RegularBlack,
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
                  style: AppStyles.text16RegularBlack,
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(
                    "30 \$",
                    style: AppStyles.text16RegularBlack,
                  ),
                )
              ],
            ),
            Text(
              'Total Price: \$${order['total'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {},
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black)),
                  child: const Text(
                    'Reorder',
                    style: AppStyles.text16BoldBlack,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: AppColors.primaryColor,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black)),
                  child: Text(
                    'cancel',
                    style:
                        AppStyles.text16BoldBlack.copyWith(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
