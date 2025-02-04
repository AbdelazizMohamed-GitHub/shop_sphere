import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key,  required this.email});
  final String email;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }
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
             CustomTextForm(
textController: emailController,
              pIcon: Icons.email,
              text: 'Email',
              kType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
           CustomButton(onPressed: () {
                
                }, text: 'Reset Password')
              
          ],
        ),
      ),
    );
  }
}
