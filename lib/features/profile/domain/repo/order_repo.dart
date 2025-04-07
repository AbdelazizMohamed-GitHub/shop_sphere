import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

abstract class OrderRepo {
  Future<Either<FirebaseFailure, void>> craeteOrders({required OrderModel orderModel});
  Future<Either<FirebaseFailure, List<OrderEntity>>> getOrders({required String status});
}