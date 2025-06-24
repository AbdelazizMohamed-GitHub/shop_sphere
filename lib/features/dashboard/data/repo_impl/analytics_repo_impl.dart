  import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/analytics_repo.dart';

class AnalyticsRepoImpl extends AnalyticsRepo {
  @override
  Future<Either<FirebaseFailure, List<int>>> getDayOrdersTotalPrice() {
    // TODO: implement getDayOrdersTotalPrice
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, int>> getOrdersTotalPriceTimeRange({required int timeRangeIndex}) {
    // TODO: implement getOrdersTotalPriceTimeRange
    throw UnimplementedError();
  }
}