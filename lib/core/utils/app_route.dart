import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    /// 🧱 شيل روت للصفحات اللي فيها drawer

    GoRoute(
      path: '/dashboard/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/dashboard/users',
      builder: (context, state) => const UsersScreen(),
    ),
    GoRoute(
      path: '/dashboard/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/dashboard/out-of-stock',
      builder: (context, state) {
        final products = state.extra;
        if (products == null || products is! List<ProductEntity>) {
          return const Scaffold(
            body: Center(child: Text('No products found!')),
          );
        }
        return OutOfStockScreen(products: products);
      },
    ),

    /// 📄 صفحات ما فيهاش Drawer (برّا ShellRoute)
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: '/product-details/:name',
      builder: (context, state) {
        final product = state.extra;
        if (product == null || product is! ProductEntity) {
          return const Scaffold(
            body: Center(child: Text('No products found!')),
          );
        }
        return DashboardProductDetailsScreen(product: product);
      },
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    )
  ],
);
