import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/view/widget/custom_register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
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
                  style: AppStyles.text26BoldBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocProvider(
                  create: (context) => AuthCubit(authRepo: AuthRepoImpl()),
                  child: const CustomRegisterBody(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
