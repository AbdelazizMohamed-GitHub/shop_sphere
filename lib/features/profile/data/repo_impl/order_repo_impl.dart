import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/order_service.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderService orderService;
  OrderRepoImpl({required this.orderService});
  @override
  Future<Either<FirebaseFailure, void>> craeteOrders(
      {required OrderModel orderModel}) async {
    try {
      await orderService.createOrder(order: orderModel);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<OrderEntity>>> getUserOrders(
      {required String status}) async {
    try {
      var data = await orderService.getUserOrders(status: status);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> deletOrder(
      {required OrderModel order}) async {
    try {
      await orderService.deleteOrder(order:order);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> changeOrdeStatus(
      {required String status, required String orderId,required int trackingNumber}) async {
    try {
      await orderService.changeOrdeStatus(status: status, orderId: orderId, trackingNumber: trackingNumber);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<OrderEntity>>> getAllOrders() async {
    try {
      var data =await orderService.getAllOrders();
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<FirebaseFailure, int>> getTrackinNumber() async{
    try {
int data=await AppFuncations.getTrackinNumber();
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<FirebaseFailure, int>> getOrderLength() async {
    try {
      int data = await orderService.getOrdersLength();
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<FirebaseFailure, List<OrderEntity>>> getCustomerOrder({required String uId}) async{
    try {
      var data = await orderService.getCustomerOrder(uId: uId);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  
}
