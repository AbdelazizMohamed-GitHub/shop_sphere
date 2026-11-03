import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocBuilder, ReadContext;
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/loading/custom_explore_screen_loading.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/widget/custom_category_list.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/dashboard_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_gride.dart';

class DashboardProductsScreen extends StatelessWidget {
  const DashboardProductsScreen({super.key, required this.onMenuPressed});

  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(dashboardRepo: getIt<DashboardRepoImpl>())
            ..getProducts(category: 'All'),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(Icons.menu),
          ),
          title: const Text(' Products'),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(AppRoute.search);
              },
              icon: const Icon(Icons.search, size: 30),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomCategoryList(
                  onTap: () async {
                    await context
                        .read<DashboardCubit>()
                        .getProducts(category: 'All');
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
              if (state is DashboardLoading) {
                return const CustomExploreScreenLoading();
              } else if (state is DashboardFailure) {
                return CustomErrorWidget(
                  errorMessage: state.errMessage,
                  onpressed: () async {
                    await context
                        .read<DashboardCubit>()
                        .getProducts(category: 'All');
                  },
                );
              } else if (state is DashboardSuccess) {
                if (state.products.isEmpty) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Center(
                        child: Text('No Products'),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: CustomProductGrid(products: state.products),
                  );
                }
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
