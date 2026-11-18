import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/core/service/analytics_service.dart';
import 'package:shop_sphere/core/service/order_service.dart';
import 'package:shop_sphere/core/service/product_service.dart';
import 'package:shop_sphere/core/service/user_service.dart';
import 'package:shop_sphere/features/analytics/data/repo_impl/analytics_repo_impl.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/dashboard_repo_impl.dart';
import 'package:shop_sphere/features/users/data/repo_impl/users_impl.dart';
import 'package:shop_sphere/features/users/data/repo_impl/notification_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/product_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/user_repo_impl.dart';


final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register Firestore instance
  getIt.registerLazySingleton<UserService>(() => UserService(firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ProductService>(() => ProductService(firestore: getIt<FirebaseFirestore>()));
    getIt.registerLazySingleton<OrderService>(() => OrderService(firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService(firestore: getIt<FirebaseFirestore>()));


  // Register FirestoreService

  // Register AuthRepo
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(userService: getIt<UserService>()));
  getIt.registerLazySingleton<ProductRepoImpl>(() => ProductRepoImpl(productService: getIt<ProductService>()));
  getIt.registerLazySingleton<FavouriteRepoImpl>(() => FavouriteRepoImpl(productService: getIt<ProductService>()));
  getIt.registerLazySingleton<CartRepoImpl>(() => CartRepoImpl(orderService: getIt<OrderService>()));
  getIt.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl(userService: getIt<UserService>()));
  getIt.registerLazySingleton<AddressRepoImpl>(() => AddressRepoImpl(userService: getIt<UserService>()));
  getIt.registerLazySingleton<OrderRepoImpl>(() => OrderRepoImpl(orderService: getIt<OrderService>()));
  getIt.registerLazySingleton<DashboardRepoImpl>(() => DashboardRepoImpl( productService:  getIt<ProductService>()));
  getIt.registerLazySingleton<NotificationRepoImpl>(() => NotificationRepoImpl());
  getIt.registerLazySingleton<AnalyticsRepoImpl>(() => AnalyticsRepoImpl(analyticsService: getIt<AnalyticsService>()));

  // Register Cubit
} 
