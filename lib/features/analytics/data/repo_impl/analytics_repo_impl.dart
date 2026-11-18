import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/analytics_service.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/domain/repo/analytics_repo.dart';

class AnalyticsRepoImpl extends AnalyticsRepo {
  final AnalyticsService analyticsService;

  AnalyticsRepoImpl({required this.analyticsService});
  @override
  Future<Either<FirebaseFailure, List<ProductMostSellerModel>>>
      getMostSoldProducts(
          {required int timeRangeIndex, required int limit}) async {
    try {
      final result = await analyticsService.getProductsMostSellerTimeRange(
          limit: limit, timeRangeIndex: timeRangeIndex);
      return Right(result);
    } on FirebaseException catch (e) { 
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<OrderOverModel>>> getOrdersOverTimeRange(
      {required int timeRangeIndex}) async {
    try {
      final result = await analyticsService.getOrdersOverTimeRange(
          timeRangeIndex: timeRangeIndex);
      return Right(result);
    } on FirebaseException catch (e) {
     
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}
