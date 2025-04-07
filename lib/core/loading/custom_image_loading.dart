import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImageLoading extends StatelessWidget {
  const CustomImageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.image,
          size: 50,
          color: Colors.black,
        ),
      ),
    );
  }
}
