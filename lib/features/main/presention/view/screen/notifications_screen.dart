import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/test/test_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: TestList.notifications.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.notifications,
                  color: AppColors.primaryColor),
              title: Text(TestList.notifications[index]['title']!),
              subtitle: Text(TestList.notifications[index]['message']!),
              trailing: Text(
                TestList.notifications[index]['time']!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
