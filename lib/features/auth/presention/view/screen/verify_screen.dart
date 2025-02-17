// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepoImpl()),
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
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
           const  Text(
              "A verification link has been sent to your",
              textAlign: TextAlign.center,
            ),
             Text(
              "$email",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  Warning.showWarning(context, message: state.errMessage);
                }
                if (state is AuthVerifiy) {
                Warning.showWarning(context, message: state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return CustomButton(
                    text: "Verify",
                    onPressed: () {
                      context.read<AuthCubit>().verifiyEmaill();
                    },
                  );

                }
              },
            ),
          ],
                  ),
          )),
    );
  }
}
