
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';


class CustomOrderStatusAction extends StatelessWidget {
  final OrderEntity order;

  const CustomOrderStatusAction({
    super.key,
    required this.order,
  });

  Future<void> _processOrder(BuildContext context) async {
    final cubit = context.read<OrderCubit>();

    await cubit.getTrackinNumber();

    await cubit.changeOrdeStatus(
      status: orderStauts[2],
      orderId: order.orderId,
      trackingNumber: cubit.currentTrackingNumber,
    );
  }

  Future<void> _completeOrder(BuildContext context) async {
    await context.read<OrderCubit>().changeOrdeStatus(
      status: orderStauts[3],
      orderId: order.orderId,
      trackingNumber: order.trackingNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case 'Pending':
        return TextButton(
          onPressed: () => _processOrder(context),
          child: const Text('Process'),
        );

      case 'Processing':
        return TextButton(
          onPressed: () => _completeOrder(context),
          child: const Text('Complete'),
        );

      default:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
    }
  }
}
