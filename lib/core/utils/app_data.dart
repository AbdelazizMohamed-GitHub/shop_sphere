import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/explore_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/favorite_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/notifications_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/profile_screen.dart';

const List<Widget> screens = [
  ExploreScreen(),
  FavoriteScreen(),
  NotificationScreen(),
  ProfileScreen(),
];
List<PaymentMethodModel> paymentMethod = [
  PaymentMethodModel(title: "Cash on delivery", imagePath: AppImages.payCash),
  PaymentMethodModel(title: "Paypal", imagePath: AppImages.paypal),
];
List orderStauts = [
  'All',
  'Pending',
  'Processing',
  'Delivered',
];

class PaymentMethodModel {
  final String title;
  final String imagePath;

  PaymentMethodModel({required this.title, required this.imagePath});
}

List appCategory = [
  "All",
  "Electronics ",
  "Clothing",
  "Home ",
  "Sports ",
  "Toys ",
  "Automotive  ",
  "Books ",
  'Fashion'
];
List timeRange = ["Daily", "Weekly", "Monthly", "Yearly"];
