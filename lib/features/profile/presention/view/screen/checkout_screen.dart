import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_cart_price.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_listile.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_payment.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: const CustomBackButton(),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Information",
                      style: AppStyles.text18RegularBlack,
                    ),
                    const CustomCheckoutListile(
                        title: "abdelaziz@gmail.com",
                        subtitle: "Email",
                        icon: Icons.email_outlined,
                        isSelect: false),
                    const CustomCheckoutListile(
                      title: "01153019984",
                      subtitle: "Phone",
                      icon: Icons.phone_outlined,
                      isSelect: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: AppStyles.text18RegularBlack,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "My Home",
                      style: AppStyles.text16BoldBlack,
                    ),
                    const Text(
                      "+20 1234567890",
                      style: AppStyles.text16RegularBlack,
                    ),
                    const Text(
                      "3 El Nozha Street, Cairo, Egypt",
                      style: AppStyles.text16RegularBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 180,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.map,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withValues(alpha: 0.5)),
                        ),
                        CustomCircleButton(
                            icon: const Icon(
                              Icons.location_on,
                              color: AppColors.primaryColor,
                            ),
                            funcation: () {})
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment Method",
                          style: AppStyles.text18RegularBlack,
                        ),
                        CustomCircleButton(
                            icon: Icon(Icons.add), funcation: () {})
                      ],
                    ),
                    CustomCheckoutPayment(),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomCartPrice(
                        title: 'Total:', price: TestList.getTotalPrice()),
                    const CustomCartPrice(title: 'Shipping:', price: 50),
                    const Divider(),
                    CustomCartPrice(
                        title: 'Total Cost:',
                        price: TestList.getTotalPrice() + 50,
                        isTotalcoast: true),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(onPressed: () {}, text: "Checkout")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
