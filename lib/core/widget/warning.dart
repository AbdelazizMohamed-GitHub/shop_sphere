import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';

class Warning {
  static void showWarning(BuildContext context, {required String message, bool isErorr=false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      
      content: Text(message),
      backgroundColor:isErorr? Colors.red:AppColors.primaryColor,
      duration: const Duration(seconds: 2),
    ));
  }
}
