import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final FirestoreService firestoreService;
  OrderRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, void>> craeteOrders(
      {required OrderModel orderModel}) async {
    try {
      await firestoreService.createOrder(order: orderModel);
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
      var data = await firestoreService.getUserOrders(status: status);
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
      await firestoreService.deleteOrder(order:order);
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
      await firestoreService.changeOrdeStatus(status: status, orderId: orderId, trackingNumber: trackingNumber);
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
      var data =await firestoreService.getAllOrders();
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
int data= await firestoreService.getTrackinNumber();
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
      int data = await firestoreService.getOrdersLength();
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
      var data = await firestoreService.getCustomerOrder(uId: uId);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  
}
