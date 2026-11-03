import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/cubits/sign_out_cubit/sign_out_cubit.dart';

import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';

class CustomProductScreenDrawer extends StatelessWidget {
  const CustomProductScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColors.backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                  ),
                  accountName: Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                        'Admin Name',
                    style: AppStyles.text16Bold.copyWith(color: Colors.black),
                  ),
                  accountEmail: Text(
                    FirebaseAuth.instance.currentUser?.email ?? 'Admin Email',
                    style:
                        AppStyles.text14Regular.copyWith(color: Colors.black),
                  ),
                  currentAccountPicture: const Image(
                    image: AssetImage(AppImages.logo),
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  )),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dashboardDrawerItems.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
                itemBuilder: (BuildContext context, int index) {
                  final isSelected = state.screenIndex == index;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      tileColor: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: Icon(
                        dashboardDrawerItems[index].icon,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      title: Text(
                        dashboardDrawerItems[index].title,
                        style: AppStyles.text18Regular.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        context
                            .read<DashboardCubit>()
                            .changeScreenIndex(index: index);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              const Divider(),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () async {
                  try {
                    await context.read<SignOutCubit>().signOut();

                    context.pushNamed(AppRoute.getStarted);
                  } catch (e) {
                    Warning.showWarning(context,
                        message: 'Error signing out. Please try again.',
                        isError: true);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
