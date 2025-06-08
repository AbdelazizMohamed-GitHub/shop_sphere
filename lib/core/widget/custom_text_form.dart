import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(

      {super.key,
       this.pIcon,
      this.lines = 1,
      this.sIcon,
      required this.text,
      this.textController,
      this.obscureText = false,
      this.onChanged,
      required this.kType
      , this.validator});
  final IconData? pIcon;
  final Widget? sIcon;
  final String text;
  final TextEditingController? textController;
  final bool obscureText;
  final TextInputType kType;
  final int lines ;
  final void Function(String)? onChanged;
   final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(maxLines: lines,
    onChanged:onChanged ,
      obscureText: obscureText,
      keyboardType: kType,
      validator:validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $text';
        }
        return null;
      },
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          errorBorder: border,
          focusedErrorBorder: border,
          disabledBorder: border,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor)),
          enabledBorder: border,
          prefixIcon: Icon(pIcon),
          suffixIcon: sIcon?? const SizedBox(),
          hintText: text),
    );
  }
}

var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey));
