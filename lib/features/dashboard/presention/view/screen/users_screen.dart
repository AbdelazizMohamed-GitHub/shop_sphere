import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/mange_users_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/mange_users/mange_users_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_notification_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/customer_order.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/staff_product_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MangeUsersCubit(mangeUsersRepo: getIt<MangeUsersRepoImpl>())
            ..getUsers(isStaff: true),
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
                  return Center(
                    child: Text(state.errMessage),
                  );
                } else if (state is MangeUsersSuccess) {
                  return state.users.isEmpty
                      ? const Center(child: Text("No Users Found"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: state.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                currentIndex == 0
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StaffProductScreen(
                                                  staffId:
                                                      state.users[index].uid,
                                                )))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerOrderScreen(
                                                  userId:
                                                      state.users[index].uid,
                                                  userName:
                                                      state.users[index].name,
                                                )));
                              },
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    title: Text(state.users[index].name,
                                        style: AppStyles.text16Bold),
                                    subtitle: Text(state.users[index].email),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddNotificationScreen(
                                              userName: state.users[index].name,
                                              fCM: state.users[index].fcmToken,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.message_rounded),
                                    ),
                                    leading: Image.asset(AppImages.profile)),
                              ),
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
