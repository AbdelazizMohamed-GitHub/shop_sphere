import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/mange_users_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/mange_users/mange_users_cubit.dart';

class StaffProductScreen extends StatelessWidget {
  const StaffProductScreen({
    super.key,
    required this.staffId,
  });
  final String staffId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MangeUsersCubit(mangeUsersRepo: getIt<MangeUsersRepoImpl>())
            ..getStaffProducts(staffId: staffId),
      child: BlocBuilder<MangeUsersCubit, MangeUsersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              leadingWidth: 100,
              title: const Text("Staff Product"),
              actions: [
                Text(
                    "Total: ${state is MangeStaffProductsSuccess ? state.products.length : 0}"),
               const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: BlocBuilder<MangeUsersCubit, MangeUsersState>(
              builder: (context, state) {
                if (state is MangeUsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MangeStaffProductsSuccess) {
                  return state.products.isEmpty
                      ? const Center(child: Text("No Products Found"))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomDashboardProductItem(
                                product: state.products[index]);
                          },
                        );
                } else {
                  return state is MangeUsersFailure
                      ? Center(child: Text(state.errMessage))
                      : const Center(child: Text("Something went wrong"));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
