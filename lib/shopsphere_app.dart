import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/dashboard_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart' show MainScreen;
import 'package:shop_sphere/features/onboarding/presention/view/screen/get_started_screen.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/user_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_cubit.dart';

class ShopSphere extends StatefulWidget {
  const ShopSphere({super.key});

  @override
  State<ShopSphere> createState() => _ShopSphereState();
}

class _ShopSphereState extends State<ShopSphere> {
  UserEntity? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final doc = await getIt<FirestoreService>().getUserData();

        setState(() {
          user = doc;
          isLoading = false;
        });
      } on Exception catch (e) {
        setState(() {
          isLoading = false;
        });
        throw Exception("Error loading user data: $e");
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(
          create: (context) =>
              FavouriteCubit(favouriteRepo: getIt<FavouriteRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              AddressCubit(addressRepo: getIt<AddressRepoImpl>()),
        ),
        BlocProvider(
            create: (context) => CartCubit(cartRepo: getIt<CartRepoImpl>())),
        BlocProvider(
            create: (context) => UserCubit(userRepo: getIt<UserRepoImpl>())),
        BlocProvider(
          create: (context) => DashboardCubit(
              dashboardRepo: getIt<DashboardRepoImpl>()
                ),
        ),
        BlocProvider(
          create: (context) => OrderCubit(orderRepo: getIt<OrderRepoImpl>()),
        ),
      ],
      child: BlocBuilder<AppCubit, bool>(
        builder: (context, isLightTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopSphere',
            themeMode: ThemeMode.system,
            theme:isLightTheme? AppTheme.lightTheme : AppTheme.darkTheme,
            home: isLoading
                ? const Scaffold(
                    body: Center(child: CircularProgressIndicator()))
                : FirebaseAuth.instance.currentUser == null
                    ? const GetStartedScreen()
                    : (user?.isStaff ?? false)
                        ? const ProductScreen()
                        : const MainScreen(),
          );
        },
      ),
    );
  }
}
