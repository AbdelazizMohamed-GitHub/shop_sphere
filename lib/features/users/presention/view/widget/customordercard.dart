import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class CustomOrderCard extends StatelessWidget {
  const CustomOrderCard({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.pushNamed(
            AppRoute.orderDetails,
            pathParameters: {'orderId': order.orderId},
            extra: order,
          );
        },
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: order.items.isNotEmpty ? order.items[0].productImage : '',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
          ),
          title: Text(
            'Tracking Number: ${order.status == 'Pending' ? '******' : order.trackingNumber}',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${DateFormat.yMMMEd().format(order.orderDate)}'),
              Text(
                order.status,
                style: TextStyle(
                  color: AppFuncations.getStatusColor(order.status),
                ),
              ),
            ],
          ),
          trailing: Text('\$${order.totalAmount}', style: AppStyles.text16Bold),
        ),
      ),
    );
  }
}
