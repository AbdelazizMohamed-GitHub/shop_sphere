import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';


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
       CustomTextForm(textController: emailTextC,
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
      CustomButton(onPressed: () {},
          text: 'Register')
    ]);
  }
}
