
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomProductScreenDrawer extends StatelessWidget {
  const CustomProductScreenDrawer({
    super.key,
    required this.outOfStock,
  });
  final List<ProductEntity> outOfStock;
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
                    "Abdelaziz Mohamed",
                    style: AppStyles.text16Bold.copyWith(color: Colors.black),
                  ),
                  accountEmail: Text(
                    "abdelaziz@email.com",
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
                  return const SizedBox(height: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: state.screenIndex == index
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(dashboardDrawerItems[index].icon,
                          color: state.screenIndex == index
                              ? Colors.white
                              : Colors.black),
                      title: Text(
                        dashboardDrawerItems[index].title,
                        style: AppStyles.text18Regular.copyWith(
                          color: state.screenIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        if (ResponsiveLayout.isDesktop(context)) {
                          context
                              .read<DashboardCubit>()
                              .changeScreenIndex(index);
                          context
                              .goNamed(tabs[index]);

                         
                        } else {
                          // قفل الـ Drawer أولاً
                          Navigator.pop(context);

                          // ثم التنقل للشاشة المطلوبة
                          if (index <= 3) {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return dashboardDrawerItems[index].screen;
                            }));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return OutOfStockScreen(products: outOfStock);
                            }));
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
