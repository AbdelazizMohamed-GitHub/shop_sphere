import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/screens_list.dart';
import 'package:shop_sphere/core/test/test_list.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text('Notifications'),
        leading: CustomCircleButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          funcation: () {
            context.read<MainCubit>().changeScreenIndex(0);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: TestList.notifications.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: index % 2 == 0
                  ? const Icon(Icons.notifications,
                      size: 40, color: AppColors.primaryColor)
                  : Image.asset(
                      AppImages.product,
                      fit: BoxFit.fill,
                    ),
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
