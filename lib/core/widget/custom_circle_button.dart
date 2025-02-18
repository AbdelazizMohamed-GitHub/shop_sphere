// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    Key? key,
    required this.icon,required this.funcation,
  }) : super(key: key);
  final Icon icon;
 final void Function()? funcation;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        radius: 20,
        child: IconButton(onPressed: funcation, icon: icon));
  }
}
