import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/forget_password_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/register_screen.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/product_list_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_products_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_search_result.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_layout.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/chat_screen.dart'
    as chatbot;
import 'package:shop_sphere/features/explor/presention/view/screen/details_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/explore_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/favorite_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/search_resualt_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/search_screen.dart'
    as explore_search;
import 'package:shop_sphere/features/explor/presention/view/screen/see_all_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/notifications_screen.dart';
import 'package:shop_sphere/features/onboarding/presention/view/screen/get_started_screen.dart';
import 'package:shop_sphere/features/onboarding/presention/view/screen/onboarding_screen.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/checkout_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/edit_profile_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_details_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_done_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_screen.dart'
    as profile;
import 'package:shop_sphere/features/profile/presention/view/screen/profile_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/massage_screen.dart'
    as staff_chat;
import 'package:shop_sphere/features/users/presention/view/screen/add_notification_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/customer_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/staff_product_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/role-check",
  debugLogDiagnostics: true,
  errorBuilder: (context, state) {
    return const Center(
      child: Text('Error'),
    );
  },
  routes: [
    GoRoute(
      path: "/role-check",
      builder: (context, state) {
        return FutureBuilder<UserEntity>(
          future: getIt<FirestoreService>().getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final userEntity = snapshot.data!;
            if (userEntity.isStaff) {
              // روح للـ Dashboard
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go("/dashboard");
              });
            } else {
              // روح للـ Main
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go("/main");
              });
            }

            return const SizedBox.shrink(); // شاشة فاضية مؤقتة
          },
        );
      },
    ),
    GoRoute(
      name: AppRoute.loading,
      path: "/loading",
      builder: (context, state) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
    GoRoute(
      name: AppRoute.getStarted,
      path: "/get-started",
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      name: AppRoute.onboarding,
      path: "/onboarding",
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: AppRoute.main,
      path: "/main",
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      name: AppRoute.explore,
      path: "/explore",
      builder: (context, state) => const ExploreScreen(),
    ),
    GoRoute(
      name: AppRoute.favorite,
      path: "/favorites",
      builder: (context, state) => const FavoriteScreen(),
    ),
    GoRoute(
      name: AppRoute.notifications,
      path: "/notifications",
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      name: AppRoute.profile,
      path: "/profile",
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      name: AppRoute.cart,
      path: "/cart",
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      name: AppRoute.checkout,
      path: "/checkout",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return CheckoutScreen(
          total: extra['total'] as double,
          cartItems: extra['cartItems'] as List<CartItemModel>,
        );
      },
    ),
    GoRoute(
      name: AppRoute.address,
      path: "/address",
      builder: (context, state) => AddressScreen(
        selectAddressIndex: state.extra as int? ?? 0,
      ),
    ),
    GoRoute(
      name: AppRoute.addNewAddress,
      path: "/add-address",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return AddNewAddressScreen(
          isupdate: extra?['isupdate'] as bool? ?? false,
          addressEntity: extra?['addressEntity'] as AddressEntity?,
        );
      },
    ),
    GoRoute(
      name: AppRoute.editProfile,
      path: "/edit-profile",
      builder: (context, state) =>
          EditProfileScreen(user: state.extra as UserEntity),
    ),
    GoRoute(
      name: AppRoute.orderHistory,
      path: "/order-history",
      builder: (context, state) => const profile.OrderScreen(),
    ),
    GoRoute(
      name: AppRoute.orderDone,
      path: "/order-done",
      builder: (context, state) => const OrderDoneScreen(),
    ),
    GoRoute(
      name: AppRoute.profileOrderDetails,
      path: "/profile-order-details",
      builder: (context, state) =>
          OrderDetailsScreen(order: state.extra as OrderEntity),
    ),
    GoRoute(
      name: AppRoute.searchResult,
      path: "/search-results",
      builder: (context, state) => SearchResualtScreen(
        products: state.extra as List<ProductEntity>,
      ),
    ),
    GoRoute(
      name: AppRoute.productSearch,
      path: "/product-search",
      builder: (context, state) => const explore_search.SearchScreen(),
    ),
    GoRoute(
      name: AppRoute.seeAll,
      path: "/see-all",
      builder: (context, state) => SeeAllScreen(
        products: state.extra as List<ProductEntity>,
      ),
    ),
    GoRoute(
      name: AppRoute.chatbot,
      path: "/chatbot",
      builder: (context, state) =>
          chatbot.ChatScreen(userId: state.extra as String),
    ),
    GoRoute(
      name: AppRoute.staffChat,
      path: "/staff-chat",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return staff_chat.ChatScreen(
          staffId: extra['staffId'] as String,
          customerId: extra['customerId'] as String,
        );
      },
    ),
    GoRoute(
      name: AppRoute.dashboard,
      path: '/dashboard',
      builder: (context, state) => const DashBoardLayout(),
    ),
    GoRoute(
      name: AppRoute.dashboardProducts,
      path: '/dashboard/products',
      builder: (context, state) => DashboardProductsScreen(
        onMenuPressed: () => context.goNamed(AppRoute.dashboard),
      ),
    ),
    GoRoute(
      name: AppRoute.analyticsProducts,
      path: '/dashboard/analytics/products',
      builder: (context, state) => ProductListScreen(
        products: state.extra as List<ProductMostSellerModel>,
      ),
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
      builder: (context, state) => OrdersScreen(
        onMenuPressed: () => context.goNamed(AppRoute.dashboard),
      ),
    ),
    GoRoute(
      name: AppRoute.users,
      path: '/dashboard/users',
      builder: (context, state) => UsersScreen(
        onMenuPressed: () => context.goNamed(AppRoute.dashboard),
      ),
    ),
    GoRoute(
      name: AppRoute.analytics,
      path: '/dashboard/analytics',
      builder: (context, state) => AnalyticsScreen(
        onMenuPressed: () => context.goNamed(AppRoute.dashboard),
      ),
    ),
    GoRoute(
      name: AppRoute.outOfStock,
      path: '/dashboard/out-of-stock',
      builder: (context, state) => OutOfStockScreen(
        products: state.extra as List<ProductEntity>? ?? const [],
      ),
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
      path: '/details/:productId',
      name: AppRoute.detailsScreen,
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        final product =
            state.extra is ProductEntity ? state.extra as ProductEntity : null;
        if (product != null) {
          return ProductDetailsScreen(product: product);
        }
        return FutureBuilder<ProductEntity>(
          future: FirestoreService.getProductById(productId: productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Could not load product: ${snapshot.error}'),
                ),
              );
            }
            return ProductDetailsScreen(product: snapshot.data!);
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
        final products = (state.extra as List<ProductEntity>?) ?? [];
        if (products.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No products found')),
          );
        }

        return DashboardSearchResult(products: products);
      },
    ),
    GoRoute(
      name: AppRoute.customerOrders,
      path: '/customer-orders',
      builder: (context, state) {
        final customer = state.extra as UserEntity;
        return CustomerOrderScreen(customer: customer);
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
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final goingTo = state.uri.toString();

    // لو مفيش يوزر
    if (user == null) {
      // استثني مسارات الـ auth
      final allowedPaths = [
        "/get-started",
        "/onboarding",
        "/login",
        "/register",
        "/forgot-password",
      ];

      // ✅ استخدم startsWith عشان يشمل أي param بعد /forgot-password
      if (allowedPaths.any((path) => goingTo.startsWith(path))) {
        return null;
      }

      return "/get-started";
    }

    // لو في يوزر مسجّل دخول
    if (goingTo == "/get-started" ||
        goingTo.startsWith("/forgot-password") ||
        goingTo == "/login" ||
        goingTo == "/signup") {
      return "/role-check"; // أو "/dashboard"
    }

    return null;
  },
);
