import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_body.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/explore_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/favorite_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/notifications_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/profile_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

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

class DashboardDrawerModel {
  final String title;
  final IconData icon;
  final Widget screen;

  DashboardDrawerModel(
      {required this.title, required this.icon, required this.screen});
}

List<DashboardDrawerModel> dashboardDrawerItems = [
  DashboardDrawerModel(
      title: 'Dashboard',
      icon: Icons.shopping_bag,
      screen: CustomProductScreenBody(
        products: const [], // Placeholder, will be updated with actual products

        onCategoryChanged: (String value) {},
      )),
  DashboardDrawerModel(
      title: 'Orders', icon: Icons.shopping_cart, screen: const OrdersScreen()),
  DashboardDrawerModel(
      title: 'Users', icon: Icons.people, screen: const UsersScreen()),
  DashboardDrawerModel(
      title: 'Analytics',
      icon: Icons.analytics,
      screen: const AnalyticsScreen()),
  DashboardDrawerModel(
      title: 'Out of Stock',
      icon: Icons.warning,
      screen: const OutOfStockScreen(
          products: [])), // Placeholder, will be updated with actual products
];
final List<String> tabs = [
  '/dashboard',
  '/dashboard/orders',
  '/dashboard/users',
  '/dashboard/analytics',
  '/dashboard/out-of-stock',
];
List appCategory = [
  "All",
  "Electronics ",
  "Clothing",
  "Home ",
  "Sports ",
  "Toys ",
  "Automotive  ",
  "Books ",
  'Fashion',
  'Beauty	',
  'Health	',
];
List timeRange = ["Daily", "Weekly", "Monthly", "Yearly"];
List weekDays = ['Satur', 'Sun', 'Mon', 'Tues', 'Wednes', 'Thurs', 'Fri'];
List<String> egyptGovernorates = [
  'Cairo',
  'Giza',
  'Qalyubia',
  'Alexandria',
  'Dakahlia',
  'Red Sea',
  'Beheira',
  'Fayoum',
  'Gharbia',
  'Ismailia',
  'Menoufia',
  'Minya',
  'New Valley',
  'Suez',
  'Aswan',
  'Assiut',
  'Beni Suef',
  'Port Said',
  'Damietta',
  'Sharqia',
  'South Sinai',
  'Kafr El Sheikh',
  'Matrouh',
  'Luxor',
  'Qena',
  'North Sinai',
  'Sohag'
];
Map<String, double> shippingPrices = {
  'Cairo': 50.0,
  'Giza': 50.0,
  'Qalyubia': 60.0,
  'Alexandria': 80.0,
  'Dakahlia': 80.0,
  'Red Sea': 100.0,
  'Beheira': 90.0,
  'Fayoum': 90.0,
  'Gharbia': 80.0,
  'Ismailia': 80.0,
  'Menoufia': 80.0,
  'Minya': 90.0,
  'New Valley': 90.0,
  'Suez': 90.0,
  'Aswan': 120.0,
  'Assiut': 90.0,
  'Beni Suef': 80.0,
  'Port Said': 90.0,
  'Damietta': 80.0,
  'Sharqia': 80.0,
  'South Sinai': 120.0,
  'Kafr El Sheikh': 100.0,
  'Matrouh': 120.0,
  'Luxor': 100.0,
  'Qena': 110.0,
  'North Sinai': 120.0,
  'Sohag': 100.0,
  'Other': 100.0,
};
Map<String, String> getegyptGovernorates = {
  'محافظة القاهرة': 'Cairo',
  'محافظة الجيزة': 'Giza',
  'محافظة الإسكندرية': 'Alexandria',
  'محافظة الدقهلية': 'Dakahlia',
  'محافظة البحر الأحمر': 'Red Sea',
  'محافظة البحيرة': 'Beheira',
  'محافظة الفيوم': 'Fayoum',
  'محافظة الغربية': 'Gharbia',
  'محافظة الإسماعيلية': 'Ismailia',
  'محافظة المنوفية': 'Monufia',
  'محافظة المنيا': 'Minya',
  'محافظة القليوبية': 'Qalyubia',
  'محافظة الوادي الجديد': 'New Valley',
  'محافظة السويس': 'Suez',
  'محافظة اسوان': 'Aswan',
  'محافظة اسيوط': 'Assiut',
  'محافظة بني سويف': 'Beni Suef',
  'محافظة بورسعيد': 'Port Said',
  'محافظة دمياط': 'Damietta',
  'محافظة الشرقية': 'Sharqia',
  'محافظة جنوب سيناء': 'South Sinai',
  'محافظة كفر الشيخ': 'Kafr El Sheikh',
  'محافظة مطروح': 'Matrouh',
  'محافظة الأقصر': 'Luxor',
  'محافظة قنا': 'Qena',
  'محافظة شمال سيناء': 'North Sinai',
  'محافظة سوهاج': 'Sohag',
};
String formatLabel({required date, required int period}) {
  switch (period) {
    case 0:
      return DateFormat.H().format(date); // الساعة
    case 1:
      return DateFormat.E().format(date); // Mon, Tue...
    case 2:
      return DateFormat.Md().format(date); // 7/5
    case 3:
      return DateFormat.MMM().format(date); // Jan, Feb...
    default:
      return '';
  }
}
