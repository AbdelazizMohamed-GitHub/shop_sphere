import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/users/data/repo_impl/users_impl.dart';
import 'package:shop_sphere/features/users/presention/controller/user_cubit/users_cubit.dart';
import 'package:shop_sphere/features/users/presention/view/widget/custom_user_item.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int currentIndex = 0;
    late MangeUsersCubit usersCubit;
  @override
  void initState() {
   usersCubit = MangeUsersCubit(mangeUsersRepo: getIt<UsersRepoImpl>())
      ..getUsers(isStaff: true);
    super.initState();
  }
  @override
  void dispose() {
    usersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return BlocProvider.value(
      value: usersCubit,
      child: Builder(
        builder: (context) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Users"),
                bottom: TabBar(
                  onTap: (value) async {
                    setState(() {
                      currentIndex = value;
                    });
                    if (value == 0) {
                      await context
                          .read<MangeUsersCubit>()
                          .getUsers(isStaff: true);
                    } else if (value == 1) {
                      await context
                          .read<MangeUsersCubit>()
                          .getUsers(isStaff: false);
                    }
                  },
                  tabs: const [
                    Tab(text: "Staff"),
                    Tab(text: "Customers"),
                  ],
                ),
              ),
              body: BlocBuilder<MangeUsersCubit, MangeUsersState>(
                  builder: (context, state) {
                if (state is MangeUsersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MangeUsersFailure) {
                  return CustomErrorWidget(
                    errorMessage: state.errMessage,
                    onpressed: () async {
                      currentIndex == 0
                          ? await context
                              .read<MangeUsersCubit>()
                              .getUsers(isStaff: true)
                          : await context
                              .read<MangeUsersCubit>()
                              .getUsers(isStaff: false);
                    },
                  );
                } else if (state is MangeUsersSuccess) {
                  return state.users.isEmpty
                      ? const Center(child: Text("No Users Found"))
                      : isMobile
                          ? ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              itemCount: state.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CustomUserItem(
                                  currentIndex: currentIndex,
                                  index: index,
                                  users: state.users,
                                );
                              },
                            )
                          : GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              itemCount: state.users.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 450,
                                mainAxisExtent: 100,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 3,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return CustomUserItem(
                                  currentIndex: currentIndex,
                                  index: index,
                                  users: state.users,
                                );
                              },
                            );
                }
                return Container();
              }),
            ),
          );
        },
      ),
    );
  }
}
