import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_images.dart';

class CustomAddPhoto extends StatefulWidget {
  const CustomAddPhoto({super.key});

  @override
  State<CustomAddPhoto> createState() => _CustomAddPhotoState();
}

class _CustomAddPhotoState extends State<CustomAddPhoto> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: image == null
              ? const AssetImage(AppImages.profile)
              : FileImage(image!),
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
                onPressed: () async {
                  image = await AppFuncations.pickImageFromGallery();
                  setState(() {});
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
