import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                AppImages.logo,
                color: Colors.white,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const Text('Shop Sphere', style: AppStyles.text22SemBoldWhite),
            ]),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                      const Text('Login', style: AppStyles.text26BoldBlack),
                      Row(
                        children: [
                          const Text('Don\'t have an account?',
                              style: AppStyles.text18RegularBlack),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Register',
                              style: AppStyles.text18RegularBlack.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const CustomTextForm(
                        pIcon: Icons.email,
                        text: 'Email',
                        textController: null,
                        obscureText: false,
                        kType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomTextForm(
                        pIcon: Icons.lock,
                        text: 'Password',
                        textController: null,
                        obscureText: true,
                        kType: TextInputType.visiblePassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: AppStyles.text18RegularBlack.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomButton(onPressed: () {}, text: 'Login'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              height: 40,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('OR',
                                style: AppStyles.text26BoldBlack
                                    .copyWith(fontWeight: FontWeight.w400)),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.google),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Sign in with Google',
                              style: AppStyles.text22SemiBoldBlack,
                            )
                          ],
                        ),
                      ),
                    ]))
          ]),
        ),
      ),
    );
  }
}
