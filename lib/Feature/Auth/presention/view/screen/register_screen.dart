// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_sphere/Feature/Auth/presention/view/widget/custom_register_body.dart';
import 'package:shop_sphere/core/constant/app_colors.dart';
import 'package:shop_sphere/core/constant/app_syles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(1, 2),
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    )),
                const Text(
                  'Register',
                  style: AppStyles.text30Bold,
                ),
                Row(children: [
                  const Text(
                    'Already have an account ? ',
                    style: AppStyles.text18RegularBlack,
                  ),
                  InkWell(
                    child: Text(
                      'Login',
                      style: AppStyles.text18RegularBlack
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                CustomRegisterBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
