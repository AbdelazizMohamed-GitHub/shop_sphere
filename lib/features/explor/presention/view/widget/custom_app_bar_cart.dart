import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';

class CustomAppBarCart extends StatelessWidget {
  const CustomAppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart, size: 25),
              ),
              const Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 8,
                ),
              ),
            ],
          );
  }
}