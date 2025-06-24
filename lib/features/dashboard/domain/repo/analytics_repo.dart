import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class AnalyticsRepo {
  Future<Either<FirebaseFailure, int>> getOrdersTotalPriceTimeRange(
      {required int timeRangeIndex});
  Future<Either<FirebaseFailure, List<int>>> getDayOrdersTotalPrice();
}
