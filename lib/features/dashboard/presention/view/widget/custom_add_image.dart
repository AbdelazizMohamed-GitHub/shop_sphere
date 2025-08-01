// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomAddImage extends StatefulWidget {
  const CustomAddImage({super.key, this.onTap, required this.imageUrl});
  final void Function(File file)? onTap;
  final String? imageUrl;
  @override
  State<CustomAddImage> createState() => _CustomAddImageState();
}

class _CustomAddImageState extends State<CustomAddImage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.backgroundDarkColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.imageUrl != ""
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:CachedNetworkImage(imageUrl: widget.imageUrl!, fit: BoxFit.cover,
              placeholder: (context, url) => const CustomImageLoading(),),
            )
          : imageFile == null
              ? GestureDetector(
                  onTap: () async {
                    File? image = await AppFuncations.pickImageFromGallery();
                    if (image != null) {
                      setState(() {
                        imageFile = image;
                      });
                      widget.onTap!(imageFile!);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      SizedBox(width: 10),
                      Text(
                        "Tap to select an image",
                        style: AppStyles.text16Regular,
                      ),
                    ],
                  ),
                )
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(imageFile!, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageFile = null;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
