
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';

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
 static Future<bool> isOnline() async {
  // final result = await Connectivity().checkConnectivity();
  // // ignore: unrelated_type_equality_checks
  // return result != ConnectivityResult.none;
  
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    
  }
}

 static Color getColorForProduct(String name) {
    if (name == "أخرى") return Colors.grey.shade700;
    const colors = Colors.primaries;
    final index = name.hashCode % colors.length;
    return colors[index];
  }

static Future<Uint8List?> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 20,
  );

  if (image != null) {
    return await image.readAsBytes(); // هنا بنرجع Uint8List
  } else {
    return null;
  }
}

 static double getShippingPrice(String governorate) {
  return shippingPrices[governorate] ?? shippingPrices['Other']!;
}
  // افترض عندك ordersOver الأصلي
static List<OrderOverModel> fillMissing(
    List<OrderOverModel> ordersOver, int timeRangeIndex) {
  DateTime now = DateTime.now();
  List<DateTime> allDates = [];

  if (timeRangeIndex == 0) {
    // يوم واحد
    allDates.add(DateTime(now.year, now.month, now.day));
  } else if (timeRangeIndex == 1) {
    // الأسبوع الحالي
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      allDates.add(DateTime(date.year, date.month, date.day));
    }
  } else if (timeRangeIndex == 2) {
    // الشهر الحالي
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      allDates.add(DateTime(now.year, now.month, i));
    }
  } else if (timeRangeIndex == 3) {
    // السنة الحالية
    for (int m = 1; m <= 12; m++) {
      allDates.add(DateTime(now.year, m, 1));
    }
  }

  // إنشاء قائمة جديدة لكل الأيام
  List<OrderOverModel> filledOrders = allDates.map((date) {
    final existing =
        ordersOver.firstWhere((e) => isSameDay(e.time, date), orElse: () => OrderOverModel(time: date, count: 0, totalCost: 0));
    return existing;
  }).toList();

  return filledOrders;
}

// دالة مساعدة للتحقق من نفس اليوم
static bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

}
