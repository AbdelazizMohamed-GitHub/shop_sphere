import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

sealed class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderChangeStatus extends OrderState {}

final class DeletOrderLoading extends OrderState {}

final class UpdateOrderLoading extends OrderState {}

final class GetOrderLoading extends OrderState {}

final class OrderError extends OrderState {
  final String error;
  OrderError({required this.error});
}
final class GetOrderError extends OrderState {
  final String error;
  GetOrderError({required this.error});
}


final class OrderSuccess extends OrderState {
  final List<OrderEntity> orders;
  OrderSuccess({required this.orders});
}

final class GetTrackingNumber extends OrderState {
  final int trackingNumber;

  GetTrackingNumber({required this.trackingNumber});

}
final class GetOrderLength extends OrderState {
  final int orderLength;

  GetOrderLength({required this.orderLength});
}
final class CreateOrderLoading extends OrderState {}
final class GetCustomerOrder extends OrderState {
  final List<OrderEntity> orders;

  GetCustomerOrder({required this.orders});
}
