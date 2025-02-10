import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepoImpl()),
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.verifiy,
            height: 200,
            width: 200,
          ),
          const Text(
            "Verify your email",
            textAlign: TextAlign.center,
          ),
          const Text(
            "A verification link has been sent to your email",
            textAlign: TextAlign.center,
          ),
          const Text(
            "Test@gmail.com",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {},
                      text: "Resend",
                    );
            },
          ),
        ],
      )),
    );
  }
}
