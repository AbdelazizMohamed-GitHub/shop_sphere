import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/edit_profile_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_list_tile.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_screen_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                      "Error: ${FirebaseFailure.fromCode(snapshot.error.toString()).message}"));
            }
            if (snapshot.hasData || snapshot.data != null) {
              UserModel user = UserModel.fromMap(snapshot.data!.data()!);
    
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProfileScreenHeader(user: user),
                    CustomProfileListTile(
                      icon: Icons.person_outlined,
                      title: 'Edit Profile',
                      funcation: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfileScreen(user: user);
                        }));
                      },
                    ),
                    CustomProfileListTile(
                      icon: Icons.shopping_cart_outlined,
                      title: ' My Cart',
                      funcation: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CartScreen();
                        }));
                      },
                    ),
                    CustomProfileListTile(
                      icon: Icons.data_thresholding,
                      title: 'Orders',
                      funcation: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const OrderScreen();
                        }));
                      },
                    ),
                    CustomProfileListTile(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      funcation: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return  AddressScreen(
                            selectAddressIndex:user.addressIndex ,
                          );
                        }));
                      },
                    ),
                    
                  CustomProfileListTile(
      icon: Icons.dark_mode_outlined,
      title: 'Dark Mode',
      trailing: Switch(
          activeColor: Colors.white,
          value: active,
          onChanged: (val) {
           setState(() {
             active = val;
           });
            context.read<AppCubit>().changeTheme(context);
            setState(() {
              
            });
          },
          inactiveTrackColor: Colors.white),
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
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
