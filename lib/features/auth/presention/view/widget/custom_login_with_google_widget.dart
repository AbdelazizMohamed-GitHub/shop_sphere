import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';

class CustomLogInWithGoogle extends StatelessWidget {
  const CustomLogInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return     InkWell(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).loginWithGoogle();
                      },       
      child: Container(
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
                            style: AppStyles.text18RegularBlack,
                          )
                        ],
                      ),
                    ),
    );
  }
}