


 import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderChangeStatus extends OrderState {}
final class OrderLoading extends OrderState {}
final class OrderError extends OrderState {
  final String error;
  OrderError({required this.error});
}
final class AddOrderSuccess extends OrderState {}

final class OrderSuccess extends OrderState {
  final List<OrderEntity> orders;
  OrderSuccess({required this.orders});
}
