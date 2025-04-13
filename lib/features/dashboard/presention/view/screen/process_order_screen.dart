import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/utils/app_styles.dart';
import 'package:shop_sphere_dashboard/core/widget/custom_button.dart';
import 'package:shop_sphere_dashboard/features/presention/view/widget/custom_process_screen_item.dart';

class ProcessOrderScreen extends StatelessWidget {
  const ProcessOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 30),
        ),
        title: const Text('Process Order'),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            CustomProcessScreenItem(title: "Order Date", subTitle: "06/10/24"),

            const Divider(height: 20),
            CustomProcessScreenItem(title: "Order ID", subTitle: "19470"),
            const Divider(height: 20),
            CustomProcessScreenItem(title: "Order Status", subTitle: "Pending"),
            const Divider(height: 20),
            CustomProcessScreenItem(
              title: "Customer Name",
              subTitle: "Abdelaziz",
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Address", style: AppStyles.text18Regular),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    "Ahmed Hassan12 Tahrir Street, Apartment 5 Downtown Cairo, Cairo Governorate 11511  Egypt  +20 153019984  ",
                    style: AppStyles.text14Regular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            CustomButton(
              onPressed: () {},
              text: "Cancel Order",
              color: Colors.white,
              textColor: Colors.black,
            ),
            SizedBox(height: 20),
            CustomButton(onPressed: () {}, text: "Process Order"),
          ],
        ),
      ),
    );
  }
}
