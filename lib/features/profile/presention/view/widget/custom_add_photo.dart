import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_images.dart';

class CustomAddPhoto extends StatelessWidget {
  const CustomAddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(AppImages.profile),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  
                },
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                  size: 25,
                ),
              )),
        ),
      ],
    );
  }
}
