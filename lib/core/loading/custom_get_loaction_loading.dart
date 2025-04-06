import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomGetLoactionLoading extends StatelessWidget {
  const CustomGetLoactionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(alignment: Alignment.center,
        height: 150,
      
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.location_on_outlined,
          size: 50,
          color: Colors.black,
        ),
      ),
    );
  }
}