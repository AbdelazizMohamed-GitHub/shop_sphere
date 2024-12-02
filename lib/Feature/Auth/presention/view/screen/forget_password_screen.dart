import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_syles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              AppImages.forgetPasswordImage,
              width: 220,
              height: 220,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Forgot your password? Lets get you back on track! 🌟',
              style: AppStyles.text18RegularBlack,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextForm(
              pIcon: Icons.email,
              text: 'Email',
              kType: TextInputType.emailAddress,
            ),
           const SizedBox(
              height: 20,
            ),
            CustomButton(onPressed: () {}, text: 'Reset Password'),
          ],
        ),
      ),
    );
  }
}
