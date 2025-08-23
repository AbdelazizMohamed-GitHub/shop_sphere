import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/forget_password_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/register_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_search_result.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_layout.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/users/presention/view/screen/add_notification_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/customer_order.dart';
import 'package:shop_sphere/features/users/presention/view/screen/staff_product_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard',
 debugLogDiagnostics: true,
  errorBuilder: (context, state) {
    return const Center(
      child: Text('Error'),
    );
  },
  routes: [
    GoRoute(
      name: AppRoute.dashboard,
      path: '/dashboard',
      builder: (context, state) => const DashBoardLayout(),
    ),
    GoRoute(
      name: AppRoute.login,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: AppRoute.register,
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: AppRoute.forgotPassword,
      path: '/forgot-password/:email',
      builder: (context, state) {
        final String email = state.pathParameters['email'] ?? '';
        if (email.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Email is required')),
          );
        }
        return ForgetPasswordScreen(email: email);
      },
    ),
    GoRoute(
      name: AppRoute.verify,
      path: '/verify/:email',
      builder: (context, state) {
        final String email = state.pathParameters['email'] ?? '';
        if (email.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Email is required')),
          );
        }
        return VerifyScreen(email: email);
      },
    ),
    GoRoute(
      name: AppRoute.orders,
      path: '/dashboard/orders',
      builder: (context, state) => const DashBoardLayout(),
    ),
    GoRoute(
      name: AppRoute.users,
      path: '/dashboard/users',
      builder: (context, state) => const DashBoardLayout(),
    ),
    GoRoute(
      name: AppRoute.analytics,
      path: '/dashboard/analytics',
      builder: (context, state) => const DashBoardLayout(

      
      ),
    ),
    GoRoute(
      name: AppRoute.outOfStock,
      path: '/dashboard/out-of-stock',
      builder: (context, state) {
        final product = state.extra;
        if (product == null || product is! List<ProductEntity>) {
          return const Scaffold(
            body: Center(child: Text('No products found!')),
          );
        }
        return const DashBoardLayout(
         
        );
      },
    ),
    GoRoute(
      name: AppRoute.addProduct,
      path: '/add-product',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final isUpdate = args['isUpdate'] as bool;
        final product = args['product'] as ProductEntity?;
        return AddProductScreen(isUpdate: isUpdate, productEntity: product);
      },
    ),
    GoRoute(
      path: '/product-details/:productId',
      name: AppRoute.productDetails,
      builder: (context, state) {
        final productId = state.pathParameters['productId'];
        final product =
            state.extra is ProductEntity ? state.extra as ProductEntity : null;

        if (product != null) {
          return DashboardProductDetailsScreen(product: product);
        }

        return FutureBuilder<ProductEntity?>(
          future: FirestoreService.getProductById(productId: productId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: Text('Product not found')),
              );
            }
            return DashboardProductDetailsScreen(product: snapshot.data!);
          },
        );
      },
    ),
    GoRoute(
      name: AppRoute.orderDetails,
      path: '/order-details/:orderId',
      builder: (context, state) {
        final orderId = state.pathParameters['orderId'];
        final order =
            state.extra is OrderEntity ? state.extra as OrderEntity : null;

        if (order != null) {
          return OrdersDetailsScreen(order: order);
        }

        return FutureBuilder<OrderEntity?>(
          future: FirestoreService.getOrderById(orderId: orderId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: Text('Order not found')),
              );
            }
            return OrdersDetailsScreen(order: snapshot.data!);
          },
        );
      },
    ),
    GoRoute(
      name: AppRoute.search,
      path: '/search',
      builder: (context, state) {
        return const SearchScreen();
      },
    ),
    GoRoute(
      name: AppRoute.dashboardSearchResult,
      path: '/dashboard-search-result',
      builder: (context, state) {
        final products = state.extra as List<ProductEntity>;
        return DashboardSearchResult(products: products);
      },
    ),
    GoRoute(
      name: AppRoute.customerOrders,
      path: '/customer-orders',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final userId = extra['userId'] as String;
        final userName = extra['userName'] as String;
        return CustomerOrderScreen(userId: userId, userName: userName);
      },
    ),
    GoRoute(
      name: AppRoute.staffProductScreen,
      path: '/staff-product-screen',
      builder: (context, state) {
        final staffId = state.extra as String;
        return StaffProductScreen(
          staffId: staffId,
        );
      },
    ),
    GoRoute(
      path: '/add-notification',
      name: AppRoute.addNotification,
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
  static String dashboard = 'dashboard';
  static String login = 'login';
  static String register = 'register';
  static String forgotPassword = 'forgot-password';
  static String verify = 'verify';
  static String orders = 'Orders';
  static String users = 'Users';
  static String analytics = 'Analytics';
  static String outOfStock = 'Out of Stock';
  static String addProduct = 'add-product';
  static String productDetails = 'product-details';
  static String orderDetails = 'order-details';
  static String search = 'search';
  static String dashboardSearchResult = 'dashboard-search-result';

  static String customerOrders = 'customer-orders';
  static String staffProductScreen = 'staff-product-screen';
  static String addNotification = 'add-notification';
}
