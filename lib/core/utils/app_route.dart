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
import 'package:shop_sphere/features/users/presention/view/screen/add_notification_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/customer_order.dart';
import 'package:shop_sphere/features/users/presention/view/screen/staff_product_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.dashboard,
  routes: [
    GoRoute(
      path: AppRoute.dashboard,
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: AppRoute.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoute.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoute.forgotPassword,
      builder: (context, state) {
        final String email = state.extra as String;
        return ForgetPasswordScreen(email: email);
      },
    ),
    GoRoute(
      path: AppRoute.verify,
      builder: (context, state) {
        final String email = state.extra as String;
        return VerifyScreen(email: email);
      },
    ),
    GoRoute(
      path: AppRoute.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: AppRoute.users,
      builder: (context, state) => const UsersScreen(),
    ),
    GoRoute(
      path: AppRoute.analytics,
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: AppRoute.outOfStock,
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
      path: AppRoute.addProduct,
      builder: (context, state) {
       final extra = state.extra as Map<String, dynamic>;
        final isUpdate = extra['isUpdate'] as bool;
        final product = extra['product'] as ProductEntity;
        return AddProductScreen(
          isUpdate: isUpdate,productEntity: product,
        );
      },
    ),
    GoRoute(
      path: '${AppRoute.productDetails}/:name',
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
      path: '${AppRoute.orderDetails}/:orderId',
      builder: (context, state) {
        final order = state.extra as OrderEntity;
        return OrdersDetailsScreen(
          order: order,
        );
      },
    ),
    GoRoute(
      path: AppRoute.search,
      builder: (context, state) {
        return const SearchScreen();
      },
    ),
    GoRoute(
      path: AppRoute.dashboardSearchResult,
      builder: (context, state) {
        final products = state.extra as List<ProductEntity>;
        return DashboardSearchResult(products: products);
      },
    ),
    GoRoute(
      path: AppRoute.customerOrders,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final userId = extra['userId'] as String;
        final userName = extra['userName'] as String;
        return CustomerOrderScreen(userId: userId, userName: userName);
      },
    ),
    GoRoute(
      path: AppRoute.staffProductScreen,
      builder: (context, state) {
        final staffId = state.extra as String;
        return StaffProductScreen(
          staffId: staffId,
        );
      },
    ),
    GoRoute(
      path: AppRoute.addNotification,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final userName = extra['userName'] as String;
        final fcm = extra['fcm'] as String;
        return AddNotificationScreen(
          userName: userName,
          fCM: fcm,
        );
      },
    ),
  ],
);

class AppRoute {
  static String dashboard = '/';
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgot-password';
  static String verify = '/verify';
  static String orders = '/orders';
  static String users = '/users';
  static String analytics = '/analytics';
  static String outOfStock = '/out-of-stock';
  static String addProduct = '/add-product';
  static String productDetails = '/product-details';
  static String orderDetails = '/order-details';
  static String search = '/search';
  static String dashboardSearchResult = '/dashboard-search-result';

  static String customerOrders = '/customer-orders';
  static String staffProductScreen = '/staff-product-screen';
  static String addNotification = '/add-notification';
}
