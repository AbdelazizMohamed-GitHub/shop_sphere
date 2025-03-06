import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Done"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/orderDone.png",
              width: 250,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text("Your order has been placed successfully",
                textAlign: TextAlign.center,
                style: AppStyles.text22SemiBoldBlack),
            SizedBox(height: 20),
            Text(
              "Thank you for choosing us! Feel free to continue shopping and explore our wide range of products. Happy Shopping!",
              textAlign: TextAlign.center,
              style: AppStyles.text14Regular,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                },
                text: "Go to Home"),
          ],
        ),
      ),
    );
  }
}
