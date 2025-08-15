import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/users/data/repo_impl/users_impl.dart';
import 'package:shop_sphere/features/users/presention/controller/user_cubit/users_cubit.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context)-40;
    final isMobile = ResponsiveLayout.isMobile(context);
    return BlocProvider(
      create: (context) =>
          MangeUsersCubit(mangeUsersRepo: getIt<UsersRepoImpl>())
            ..getUsers(isStaff: true),
      child: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              context.goNamed(AppRoute.dashboard);
              return false; // يمنع الرجوع العادي
            },
            child: DefaultTabController(
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding),
                                itemCount: state.users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      currentIndex == 0
                                          ? context.goNamed(
                                              AppRoute.staffProductScreen,
                                              extra: state.users[index].uid)
                                          : context.goNamed(
                                              AppRoute.customerOrders,
                                              extra: {
                                                  'userId':
                                                      state.users[index].uid,
                                                  'userName':
                                                      state.users[index].name,
                                                });
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          title: Text(state.users[index].name,
                                              style: AppStyles.text16Bold),
                                          subtitle:
                                              Text(state.users[index].email),
                                          trailing: IconButton(
                                            onPressed: () {
                                              context.goNamed(
                                                  AppRoute.addNotification,
                                                  extra: {
                                                    'fcm': state
                                                        .users[index].fcmToken,
                                                    'userName':
                                                        state.users[index].name,
                                                  });
                                            },
                                            icon: const Icon(
                                                Icons.message_rounded),
                                          ),
                                          leading:
                                              Image.asset(AppImages.profile)),
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding),
                                itemCount: state.users.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 450,mainAxisExtent: 100, // أقصى عرض للكارت
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 3,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      currentIndex == 0
                                          ? context.goNamed(
                                              AppRoute.staffProductScreen,
                                              extra: state.users[index].uid)
                                          : context.goNamed(
                                              AppRoute.customerOrders,
                                              extra: {
                                                'userId':
                                                    state.users[index].uid,
                                                'userName':
                                                    state.users[index].name,
                                              },
                                            );
                                    },
                                    child: SizedBox(
                                      width: 300,
                                      height: 100,
                                      child: Expanded(
                                        child: Card(
                                          color: Colors.white,
                                          child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              title: Text(state.users[index].name,
                                                  maxLines: 1,
                                                  style: AppStyles.text16Bold),
                                              subtitle:
                                                  Text(state.users[index].email),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  context.goNamed(
                                                      AppRoute.addNotification,
                                                      extra: {
                                                        'fcm': state.users[index]
                                                            .fcmToken,
                                                        'userName': state
                                                            .users[index].name,
                                                      });
                                                },
                                                icon: const Icon(
                                                    Icons.message_rounded),
                                              ),
                                              leading:
                                                  Image.asset(AppImages.profile)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                  }
                  return Container();
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
