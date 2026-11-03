// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_drawer.dart';

class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({
    super.key,
  });

  @override
  State<DashBoardLayout> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<DashBoardLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCategory = "All";
  @override
  void initState() {
    final savedIndex =
        Hive.box(AppConst.dashboardScreen).get('index', defaultValue: 0);
    context.read<DashboardCubit>().changeScreenIndex(index: savedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      return Scaffold(
          key: _scaffoldKey,
          drawer: const CustomProductScreenDrawer(),
          body: SafeArea(
            child: IndexedStack(
              index: state.screenIndex,
              children: dashboardDrawerItems.map((item) {
                return item.screenBuilder(
                  () => _scaffoldKey.currentState?.openDrawer(),
                );
              }).toList(),
            ),
          ),
          floatingActionButton: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
            return state.screenIndex != 0
                ? const SizedBox()
                : FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      context.goNamed(AppRoute.addProduct,
                          extra: {'isUpdate': false, 'product': null});
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  );
          }));
    });
  }
}
