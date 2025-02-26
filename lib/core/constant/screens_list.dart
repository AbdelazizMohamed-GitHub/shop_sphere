import 'package:flutter/material.dart';
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
  PaymentMethodModel(
      title: "Cash on delivery", icon: Icons.money_off_csred_outlined),
  PaymentMethodModel(title: "Paypal", icon: Icons.paypal_outlined),
  PaymentMethodModel(title: "Credit Card", icon: Icons.credit_card_outlined)
];

class PaymentMethodModel {
  final String title;
  final IconData icon;

  PaymentMethodModel({required this.title, required this.icon});
}

List category = [
  "All",
  "1",
  "2",
  "3",
  "4",
  "5",
];
