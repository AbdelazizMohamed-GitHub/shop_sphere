


 import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderChangeStatus extends OrderState {}
final class DeletOrderLoading extends OrderState {}
final class UpdateOrderLoading extends OrderState {}
final class GetOrderLoading extends OrderState {}
final class OrderError extends OrderState {
  final String error;
  OrderError({required this.error});
}
final class AddOrderSuccess extends OrderState {}

final class OrderSuccess extends OrderState {
  final List<OrderEntity> orders;
  OrderSuccess({required this.orders});
}
