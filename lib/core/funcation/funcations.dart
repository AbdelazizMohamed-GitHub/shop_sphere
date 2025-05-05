
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Map<String, double> shippingPrices = {
  'Cairo': 40.0,
  'Giza': 50.0,
  'Qalyubia': 55.0,
  'Alexandria': 60.0,
  'Dakahlia': 70.0,
  'Luxor': 90.0,
  'Aswan': 110.0,
  'Other': 100.0, // لأي محافظة مش مذكورة
};
}
