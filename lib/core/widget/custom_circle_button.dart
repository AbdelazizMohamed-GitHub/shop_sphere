// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    super.key,
    required this.icon,
    required this.funcation,
  });
  final Icon icon;
  final void Function()? funcation;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: 20,
        child: IconButton(onPressed: funcation, icon: icon));
  }
}
