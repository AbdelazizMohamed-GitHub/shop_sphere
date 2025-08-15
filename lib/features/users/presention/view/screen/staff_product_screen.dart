import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_gride.dart';
import 'package:shop_sphere/features/users/data/repo_impl/users_impl.dart';
import 'package:shop_sphere/features/users/presention/controller/user_cubit/users_cubit.dart';

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
          MangeUsersCubit(mangeUsersRepo: getIt<UsersRepoImpl>())
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
                      : CustomProductGrid(products: state.products);
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
