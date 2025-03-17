import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/edit_profile_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_list_tile.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_screen_header.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_theme_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        authRepo: getIt<AuthRepoImpl>(),
      )..getUserData(),
      child: Scaffold(
        backgroundColor: AppTheme.isLightTheme(context)
            ? AppColors.primaryColor
            : AppColors.backgroundDarkColor,
        appBar: AppBar(
          leadingWidth: 100,
          leading: IconButton(
              onPressed: () {
                context.read<MainCubit>().changeScreenIndex(0);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.white,
              )),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.isLightTheme(context)
              ? AppColors.primaryColor
              : AppColors.secondaryDarkColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomProfileScreenHeader(),
              CustomProfileListTile(
                icon: Icons.person_outlined,
                title: 'Edit Profile',
                funcation: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EditProfileScreen();
                  }));
                },
              ),
              CustomProfileListTile(
                icon: Icons.shopping_cart_outlined,
                title: ' My Cart',
                funcation: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CartScreen();
                  }));
                },
              ),
              CustomProfileListTile(
                icon: Icons.data_thresholding,
                title: 'Orders',
                funcation: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const OrderScreen();
                  }));
                },
              ),
              CustomProfileListTile(
                icon: Icons.location_on_outlined,
                title: 'Address',
                funcation: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddressScreen();
                  }));
                },
              ),
              const CustomThemeWidget(),
              const Divider(
                color: Colors.white,
              ),
              CustomProfileListTile(
                icon: Icons.logout,
                title: 'Log Out',
                funcation: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
