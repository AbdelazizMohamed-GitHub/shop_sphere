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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
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
                const Text(
                  'Register',
                  style: AppStyles.text30Bold,
                ),
             
                Row(children: [
                  const Text(
                    'Already have an account ?',
                    style: AppStyles.text18RegularBlack,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: AppStyles.text18RegularBlack.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
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
