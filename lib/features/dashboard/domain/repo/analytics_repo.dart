import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class AnalyticsRepo {
  Future<Either<FirebaseFailure, double>> getOrdersTotalPriceTimeRange(
      {required int timeRangeIndex});
  Future<Either<FirebaseFailure, List<int>>> getDayOrdersTotalPrice();
  Future<Either<FirebaseFailure, List<String>>> getProductMostSeller({
    required int limit,required int timeRangeIndex,
  });
}
