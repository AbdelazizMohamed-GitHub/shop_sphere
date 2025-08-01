import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/cubits/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/dashboard_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/cart_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/user_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_cubit.dart';
class ShopSphere extends StatelessWidget {
  const ShopSphere({super.key});

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
              dashboardRepo: getIt<DashboardRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => OrderCubit(orderRepo: getIt<OrderRepoImpl>()),
        ),
      ],
      child: BlocBuilder<AppCubit, bool>(
        builder: (context, isLightTheme) {
          return MaterialApp.router(

            debugShowCheckedModeBanner: false,
            title: 'ShopSphere',
            themeMode: ThemeMode.system,
            theme: isLightTheme
                ? AppTheme.lightTheme
                : AppTheme.darkTheme,routerConfig: router,
            // home: StreamBuilder<User?>(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Scaffold(
            //         body: Center(child: CircularProgressIndicator()),
            //       );
            //     }

            //     if (!snapshot.hasData) {
            //       return const GetStartedScreen();
            //     }

            //     return FutureBuilder<UserEntity>(
            //       future: getIt<FirestoreService>().getUserData(),
            //       builder: (context, userSnapshot) {
            //         if (userSnapshot.connectionState == ConnectionState.waiting) {
            //           return const Scaffold(
            //             body: Center(child: CircularProgressIndicator()),
            //           );
            //         }

            //         if (userSnapshot.hasError || !userSnapshot.hasData) {
            //           return const GetStartedScreen(); // أو اعرض رسالة خطأ
            //         }

            //         final user = userSnapshot.data!;
            //         return user.isStaff
            //             ? const ProductScreen()
            //             : const MainScreen();
            //       },
            //     );
            //   },
            // ),
          );
        },
      ),
    );
  }
}

