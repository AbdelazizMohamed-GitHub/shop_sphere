import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/main/data/notification_model.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<NotificationModel>(AppConst.appNotificationBox);
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
      body:   ValueListenableBuilder(
        valueListenable:box.listenable() ,
        builder: (BuildContext context, Box<NotificationModel> box, Widget? child) {
          if (box.values.isEmpty) {
            return const Center(child: Text('لا توجد إشعارات بعد 📭'));
          }
         
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final notification = box.getAt(index);

              return ListTile(
                title: Text(notification?.title ?? ''),
                subtitle: Text(notification?.description ?? ''),
                trailing: Text(
                  notification?.date.toString().substring(0, 16) ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
