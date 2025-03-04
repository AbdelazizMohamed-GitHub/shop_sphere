import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_header.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_details_item.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_information.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const CustomBackButton(),
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOrderDetailsHeader(order: order),
            const SizedBox(height: 20),
            Text(
              '${TestList.order["items"].length} Items',
              style: AppStyles.text18RegularBlack,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  return CustomOrderDetailsItem(item: item);
                },
              ),
            ),
            CustomOrderInformation(order: order),
            const SizedBox(
              height: 20,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
