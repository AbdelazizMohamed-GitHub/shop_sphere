import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/forget_password_screen.dart';

class CustomLoginScreenBody extends StatefulWidget {
  const CustomLoginScreenBody({super.key});

  @override
  State<CustomLoginScreenBody> createState() => _CustomLoginScreenBodyState();
}

class _CustomLoginScreenBodyState extends State<CustomLoginScreenBody> {
  TextEditingController emailTextC = TextEditingController();
  TextEditingController passwordTextC = TextEditingController();

  @override
  void dispose() {
    emailTextC.dispose();
    passwordTextC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextForm(
          pIcon: Icons.email,
          text: 'Email',
          textController: emailTextC,
          obscureText: false,
          kType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextForm(
          pIcon: Icons.lock,
          text: 'Password',
          textController: passwordTextC,
          obscureText: true,
          kType: TextInputType.visiblePassword,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgetPasswordScreen(
                  email: emailTextC.text.trim(),
                ),
              ));
            },
            child: Text(
              'Forgot Password?',
              style: AppStyles.text18RegularBlack.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
             Warning.showWarning(context, message: 'Login Successfully');
            }
            if (state is AuthError) {
              Warning.showWarning(context, message: state.errMessage);
            }
          },
          builder: (context, state) {
            return state is AuthLoading
                ? const CircularProgressIndicator()
                : CustomButton(onPressed: () {
                  if (emailTextC.text.isNotEmpty &&
                      passwordTextC.text.isNotEmpty) {
                    context.read<AuthCubit>().logInWithEmailAndPassword(
                        email: emailTextC.text.trim(),
                        password: passwordTextC.text.trim());
                    
                  }
                  else {
                    Warning.showWarning(context, message: 'Please fill all fields');
                  }
                }, text: 'Login');
          },
        ),
      ],
    );
  }
}
