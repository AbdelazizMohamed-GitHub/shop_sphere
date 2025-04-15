import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';

class CustomLogInWithGoogle extends StatelessWidget {
  const CustomLogInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Warning.showWarning(context, message: state.errMessage);
        }
        if (state is AuthSuccess) {

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => state.uid=='Staff'?const DashboardScreen(): const MainScreen(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        return state is GoogleAuthLoading
            ? const Center(child: CircularProgressIndicator())
            : InkWell(
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
                        style: AppStyles.text18Regular,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
