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
      {required OrderModel orderModel}
  ) async{
    try {
      await firestoreService.createOrder(order: orderModel );
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  
  }

  @override
  Future<Either<FirebaseFailure, List<OrderEntity>>> getOrders({required String status}) async{
    
    try {
      var data = await firestoreService.getOrders(status: status);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}