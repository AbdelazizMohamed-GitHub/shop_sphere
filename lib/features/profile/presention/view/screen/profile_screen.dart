import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/edit_profile_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leadingWidth: 100,
        leading: IconButton(
            onPressed: () {
              context.read<MainCubit>().changeScreenIndex(0);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            )),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImages.profile),
            ),
            const Text(
              'User Name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? "Email",
              style: AppStyles.text18RegularWhite,
            ),
            const SizedBox(
              height: 20,
            ),
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
            CustomProfileListTile(
              icon: Icons.settings_outlined,
              title: 'Setting',
              funcation: () {},
            ),
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
    );
  }
}
