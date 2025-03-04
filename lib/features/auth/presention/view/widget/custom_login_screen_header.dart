import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/register_screen.dart';

class CustomLoginScreenHeader extends StatelessWidget {
  const CustomLoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
                    children: [
                      const Text('Don\'t have an account?',
                          style: AppStyles.text18RegularBlack),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                        },
                        child: Text(
                          'Register',
                          style: AppStyles.text18RegularBlack.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  );
  }
}