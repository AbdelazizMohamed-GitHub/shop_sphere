import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';

class CustomRegisterBody extends StatefulWidget {
  const CustomRegisterBody({super.key});

  @override
  State<CustomRegisterBody> createState() => _CustomRegisterBodyState();
}

class _CustomRegisterBodyState extends State<CustomRegisterBody> {
  bool isPassword = true;
  bool isConfirmPassword = true;
  TextEditingController nameTextC = TextEditingController();
  TextEditingController phoneTextC = TextEditingController();
  TextEditingController emailTextC = TextEditingController();
  TextEditingController passwordTextC = TextEditingController();
  TextEditingController confirmPasswordTextC = TextEditingController();
  @override
  void dispose() {
    nameTextC.dispose();
    phoneTextC.dispose();
    emailTextC.dispose();
    passwordTextC.dispose();
    confirmPasswordTextC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextForm(
        text: 'Full Name',
        textController: nameTextC,
        pIcon: Icons.person,
        kType: TextInputType.text,
      ),
      const SizedBox(height: 15),
      CustomTextForm(
        textController: phoneTextC,
        pIcon: Icons.phone,
        text: 'Phone',
        kType: TextInputType.number,
      ),
      const SizedBox(height: 15),
      CustomTextForm(
        textController: emailTextC,
        text: 'Email',
        pIcon: Icons.email,
        kType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 15),
      CustomTextForm(
        textController: passwordTextC,
        obscureText: isPassword,
        text: 'Password',
        pIcon: Icons.lock,
        kType: TextInputType.visiblePassword,
        sIcon: InkWell(
          onTap: () {
            setState(() {
              isPassword = !isPassword;
            });
          },
          child: Icon(isPassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      const SizedBox(height: 15),
      CustomTextForm(
        textController: confirmPasswordTextC,
        text: 'Confirm Password',
        pIcon: Icons.lock,
        obscureText: isConfirmPassword,
        kType: TextInputType.visiblePassword,
        sIcon: InkWell(
          onTap: () {
            setState(() {
              isConfirmPassword = !isConfirmPassword;
            });
          },
          child:
              Icon(isConfirmPassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      const SizedBox(height: 20),
      BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return  VerifyScreen(email: emailTextC.text.trim(),);
            }));
          }
          if (state is AuthError) {
            Warning.showWarning(context, message: state.errMessage);
          }
        },
        builder: (context, state) {
          return state is AuthLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  onPressed: () async {
                    if (passwordTextC.text.isNotEmpty &&
                        emailTextC.text.isNotEmpty) {
                      await context
                          .read<AuthCubit>()
                          .registerWithEmailAndPassword(
                            email: emailTextC.text.trim(),
                            password: passwordTextC.text.trim(),
                          );
                    } else {
                      Warning.showWarning(context,
                          message: 'Please Fill All Field');
                    }
                  },
                  text: 'Register');
        },
      )
    ]);
  }
}
