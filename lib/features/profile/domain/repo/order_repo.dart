import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

abstract class OrderRepo {
  Future<Either<FirebaseFailure, void>> craeteOrders({required OrderModel orderModel});
  Future<Either<FirebaseFailure, List<OrderEntity>>> getUserOrders({required String status});
  Future<Either<FirebaseFailure, void>> deletOrder({required OrderModel order});
  Future<Either<FirebaseFailure, void>> changeOrdeStatus({required String status,required String orderId,required int trackingNumber});
Future<Either<FirebaseFailure, List<OrderEntity>>> getAllOrders();
Future<Either<FirebaseFailure, int>> getTrackinNumber();
Future<Either<FirebaseFailure, int>> getOrderLength();
Future<Either<FirebaseFailure, List<OrderEntity>>> getCustomerOrder({required String uId});



}