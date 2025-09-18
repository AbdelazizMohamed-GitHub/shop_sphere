import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_layout.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_data_birth.dart';

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
  DateTime? birthDate;
  String? gender;
  @override
  void dispose() {
    nameTextC.dispose();
    phoneTextC.dispose();
    emailTextC.dispose();
    passwordTextC.dispose();
    confirmPasswordTextC.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextForm(
            text: 'Full Name',
            textController: nameTextC,
            pIcon: Icons.person,
            kType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          CustomTextForm(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number cannot be empty';
              }
              if (!RegExp(r'^\+?[0-9]{11}$').hasMatch(value)) {
                return 'Enter a valid phone number';
              }
              return null;
            },
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
                setState(
                  () {
                    isPassword = !isPassword;
                  },
                );
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
                setState(
                  () {
                    isConfirmPassword = !isConfirmPassword;
                  },
                );
              },
              child: Icon(
                  isConfirmPassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomAddBirthdate(onChanged: (valu) {
            birthDate = valu;
          }),
          const SizedBox(
            height: 15,
          ),
          CustomDropdown(
              text: 'Select Gender',
              categories: const ['Male', 'Female'],
              onCategorySelected: (valu) {
                gender = valu;
              }),
          const SizedBox(height: 20),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.goNamed(
                    state.uid == 'Staff' ? AppRoute.dashboard : AppRoute.main);
              }
              if (state is AuthError) {
                Warning.showWarning(context,
                    message: state.errMessage, isError: true);
              }
            },
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            birthDate != null &&
                            gender != null) {
                          if (passwordTextC.text == confirmPasswordTextC.text) {
                            FocusScope.of(context).unfocus();
                            await context
                                .read<AuthCubit>()
                                .registerWithEmailAndPassword(
                                  name: nameTextC.text.trim(),
                                  phoneNumber: phoneTextC.text.trim(),
                                  email: emailTextC.text.trim(),
                                  password: passwordTextC.text.trim(),
                                  birthDate: birthDate ?? DateTime.now(),
                                  gender: gender ?? "Male",
                                );
                          } else {
                            Warning.showWarning(context,
                                message: 'Password Not Match');
                          }
                        } else {
                          Warning.showWarning(context,
                              message: 'Please Fill All Field');
                        }
                      },
                      text: 'Register');
            },
          )
        ],
      ),
    );
  }
}
