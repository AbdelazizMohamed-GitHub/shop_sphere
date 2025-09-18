import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({super.key, required this.currentIndex, required this.index, required this.users});
  final int currentIndex;
  final int index;
  final List<UserEntity> users;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        currentIndex == 0
            ? context.goNamed(AppRoute.staffProductScreen,
                extra: users[index].uid)
            : context.goNamed(
                AppRoute.customerOrders,
                extra: {
                  'userId': users[index].uid,
                  'userName': users[index].name,
                },
              );
      },
      child: SizedBox(
        height: 100,
        child: Card(
          color: Colors.white,
          child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(users[index].name,
                  maxLines: 1, style: AppStyles.text16Bold),
              subtitle: Text(users[index].email, maxLines: 1),
              trailing: SizedBox(width: 80,height:  50, child: 
              Row(children: [
                IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.addNotification, extra: {
                    'fcm': users[index].fcmToken,
                    'userName': users[index].name,
                  });
                },
                icon: const Icon(Icons.message_rounded),
              ),
                Text(users[index].isStaff ? "Staff" : "Customer", style: AppStyles.text14Regular,),
                const Spacer(),
                Icon(users[index].isStaff ? Icons.admin_panel_settings : Icons.person, color: users[index].isStaff ? Colors.blue : Colors.green,)
              ],)),
              leading: Image.asset(AppImages.profile)),
        ),
      ),
    );
  }
}
