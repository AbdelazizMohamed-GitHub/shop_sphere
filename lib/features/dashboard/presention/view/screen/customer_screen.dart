import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/massage_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/notifications_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<UserEntity> users = [];
  Future<List<UserEntity>> getUsers() async {
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
    });
    return users;
  }

  @override
  void initState() {
   getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customers")),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(users[index].name, style: AppStyles.text16Bold),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                         const NotificationScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.message_rounded),
              ),
              leading:
                  const CircleAvatar(backgroundColor: AppColors.primaryColor),
              subtitle: Text("Phone $index", style: AppStyles.text14Regular),
            ),
          );
        },
      ),
    );
  }
}
