import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/forget_password_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';

class CustomLoginScreenBody extends StatefulWidget {
  const CustomLoginScreenBody({super.key});

  @override
  State<CustomLoginScreenBody> createState() => _CustomLoginScreenBodyState();
}

class _CustomLoginScreenBodyState extends State<CustomLoginScreenBody> {
  TextEditingController emailTextC = TextEditingController();
  TextEditingController passwordTextC = TextEditingController();
  bool isPassword = true;
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
          sIcon: InkWell(
            onTap: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
            child: Icon(isPassword ? Icons.visibility_off : Icons.visibility),
          ),
          pIcon: Icons.lock,
          text: 'Password',
          textController: passwordTextC,
          obscureText: isPassword,
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
              style: AppStyles.text18Regular.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => state.uid == 'Staff'
                        ? const ProductScreen()
                        : const MainScreen(),
                  ),
                  (route) => false);
            }
            if (state is AuthError) {
              print('${state.errMessage}');
              Warning.showWarning(context,
                  isError: true, message: state.errMessage);
            }
          },
          builder: (context, state) {
            return state is AuthLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    onPressed: () async {
                      if (emailTextC.text.isNotEmpty &&
                          passwordTextC.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                       
                        await context
                            .read<AuthCubit>()
                            .logInWithEmailAndPassword(
                                context: context,
                                email: emailTextC.text.trim(),
                                password: passwordTextC.text.trim());
                      } else {
                        Warning.showWarning(context,
                            message: 'Please fill all fields');
                      }
                    },
                    text: 'Login');
          },
        ),
      ],
    );
  }
}
