import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/product_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/user_repo_impl.dart';


final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register Firestore instance
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register FirestoreService
  getIt.registerLazySingleton(() => FirestoreService(firestore: getIt<FirebaseFirestore>()));

  // Register AuthRepo
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<ProductRepoImpl>(() => ProductRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<FavouriteRepoImpl>(() => FavouriteRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<CartRepoImpl>(() => CartRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<AddressRepoImpl>(() => AddressRepoImpl(firestoreService: getIt<FirestoreService>()));
  getIt.registerLazySingleton<OrderRepoImpl>(() => OrderRepoImpl(firestoreService: getIt<FirestoreService>()));

  // Register Cubit
}
