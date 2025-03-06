import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/test_data/test_list.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';
import 'package:shop_sphere/features/main/presention/view/widget/custom_notification_item.dart';

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
          ),
          funcation: () {
            context.read<MainCubit>().changeScreenIndex(0);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: TestList.notifications.length,
        itemBuilder: (context, index) {
          return CustomNotificationItem(index: index,);
        },
      ),
    );
  }
}
