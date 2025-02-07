import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/view/widget/custom_login_screen_body.dart';
import 'package:shop_sphere/features/auth/presention/view/widget/custom_login_screen_header.dart';
import 'package:shop_sphere/features/auth/presention/view/widget/custom_login_with_google_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepoImpl()),
      child: Scaffold(
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
                    const CustomLoginScreenHeader(),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomLoginScreenBody(),
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
                    const CustomLogInWithGoogle()
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
