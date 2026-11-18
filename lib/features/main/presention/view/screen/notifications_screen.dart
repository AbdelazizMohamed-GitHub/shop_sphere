import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_sphere/core/cubits/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/loading/custom_image_loading.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/features/main/data/notification_model.dart';
import 'package:shop_sphere/features/main/presention/controller/main_cubit/main_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<NotificationModel>(AppConst.appNotificationBox);
    return BlocBuilder<AppCubit, bool>(
      builder: (context, isLightTheme) {
        return Scaffold(
          backgroundColor: isLightTheme
              ? AppColors.backgroundColor
              : AppColors.backgroundDarkColor,
          appBar: AppBar(
            leadingWidth: 100,
            title: const Text('Notifications'),
            leading: IconButton(
                onPressed: () {
                  context.read<MainCubit>().changeScreenIndex(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                )),
          ),
          body: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (BuildContext context, Box<NotificationModel> box,
                Widget? child) {
              if (box.values.isEmpty) {
                return Center(
                  child: Text(
                    'No notifications found',
                    style: AppStyles.text18Regular.copyWith(
                      color: isLightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final notification = box.getAt(index);

                  return Dismissible(
                    key: ValueKey(notification?.date.toIso8601String()),
                    onDismissed: (_) => notification?.delete(),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: isLightTheme
                          ? Colors.white
                          : AppColors.secondaryDarkColor,
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: notification?.imageUrl ?? '',
                            placeholder: (context, url) =>
                            const  CustomImageLoading(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(notification?.title ?? '',
                            style: AppStyles.text16Bold),
                        subtitle: Text(notification?.description ?? '',
                            style: AppStyles.text14Regular),
                        onTap: notification == null
                            ? null
                            : () {
                                final productId =
                                    notification.productId?.trim();
                                if (productId == null || productId.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Product details are unavailable for this notification.',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                context.pushNamed(
                                  AppRoute.detailsScreen,
                                  pathParameters: {
                                    'tagId': 'notification-$productId',
                                    'productId': productId,
                                  },
                                );
                              },
                        trailing: Text(
                          notification?.date.toString().substring(0, 16) ?? '',
                          style: AppStyles.text14Regular,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
