import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/forget_password_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/register_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_search_result.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/out-of-stock',
      builder: (context, state) {
        final product = state.extra;
        if (product == null || product is! List<ProductEntity>) {
          return const Scaffold(
            body: Center(child: Text('No products found!')),
          );
        }
        return OutOfStockScreen(products: product);
      },
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
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) {
        final String email = state.extra as String;
        return ForgetPasswordScreen(email: email);
      },
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) {
        final String email = state.extra as String;
        return VerifyScreen(email: email);
      },
    ),
    GoRoute(
      path: '/add-product',
      builder: (context, state) {
        final bool isUpdate = state.extra as bool;
        return AddProductScreen(
          isUpdate: isUpdate,
        );
      },
    ),
    GoRoute(
      path: '/order-details/:orderId',
      builder: (context, state) {
        final order = state.extra as OrderEntity;
        return OrdersDetailsScreen(
          order: order,
        );
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        return const SearchScreen();
      },
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) {
        final products = state.extra as List<ProductEntity>;
        return DashboardSearchResult(products: products);
      },
    ),
  ],
);

class AppRoute {
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgot-password';
  static String verify = '/verify';
  static String addProduct = '/add-product';
  static String dashboardSearchResult = '/dashboard-search-result';

  static String search = '/search';
  static String orderDetails = '/order-details';
  static String productDetails = '/product-details';
  static String outOfStock = '/out-of-stock';
  static String users = '/users';
  static String orders = '/orders';
  static String analytics = '/analytics';
  static String dashboard = '/';
  static String addNotification = '/add-notification';
  static String customerOrders = '/customer-orders';
  static String staffProductScreen = '/staff-product-screen';
  
  

}
