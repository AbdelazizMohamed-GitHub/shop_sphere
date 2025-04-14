import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/massage_screen.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customers")),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,

        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text("Customer $index", style: AppStyles.text16Bold),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ChatScreen(staffId: '', customerId: ''),
                    ),
                  );
                },
                icon: const Icon(Icons.message_rounded),
              ),
              leading: const CircleAvatar(backgroundColor: AppColors.primaryColor),
              subtitle: Text("Phone $index", style: AppStyles.text14Regular),
            ),
          );
        },
      ),
    );
  }
}
