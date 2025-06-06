
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_sphere/core/utils/app_data.dart';

class AppFuncations {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.red;
      case 'Processing':
        return Colors.orange;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

 


 static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
 static double getShippingPrice(String governorate) {
  return shippingPrices[governorate] ?? shippingPrices['Other']!;
}
  
}
