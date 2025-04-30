import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_notification_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<UsersScreen> {
  List<UserEntity> users = [];
  List<UserEntity> filterUsers = [];
  List<UserEntity> displayUsers = [];

  Future<List<UserEntity>> getUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection("users").get();
    return snapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  void fetchUsers() async {
    final fetchedUsers = await getUsers();
    setState(() {
      users = fetchedUsers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions:const [
          // PopupMenuButton<String>(
          //   onSelected: (value) {
          //     displayUsers = filterUsers;
          //     setState(() {});
          //     // تعامل مع الاختيار
          //     if (value == 'Customers') {
          //       filterUsers = users.where((user) {
          //         return !user.isStaff;
          //       }).toList();

          //       setState(() {});

          //       // تنفذ كود التحديث
          //     } else if (value == 'Staff') {
          //       filterUsers = users.where((user) {
          //         return user.isStaff;
          //       }).toList();
          //       setState(() {});
          //     }
          //   },
          //   itemBuilder: (BuildContext context) => [
          //     const PopupMenuItem(
          //       value: 'Customers',
          //       child: Text('Customers'),
          //     ),
          //     const PopupMenuItem(
          //       value: 'Staff',
          //       child: Text('Staff'),
          //     )
          //   ],
          // )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? const Center(child: Text("No Users Founded"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                          title: Text(users[index].name,
                              style: AppStyles.text16Bold),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNotificationScreen(
                                    fCM: users[index].fcmToken,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.message_rounded),
                          ),
                          leading: Image.asset(AppImages.profile)),
                    );
                  },
                ),
    );
  }
}
