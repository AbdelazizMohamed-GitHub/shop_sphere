import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

abstract class AnalyticsRepo {
  Either<FirebaseFailure, List<OrderOverModel>> getOrdersOverTimeRange({
    required int timeRangeIndex, 
  });
  Either<FirebaseFailure,List<ProductMostSellerModel>> getMostSoldProducts({
    required int timeRangeIndex,
    required int limit,
  });
}