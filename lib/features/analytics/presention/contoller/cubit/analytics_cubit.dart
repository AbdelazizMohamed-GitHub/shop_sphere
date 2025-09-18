// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/domain/repo/analytics_repo.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({required this.analyticsRepo}) : super(AnalyticsInitial());
  final AnalyticsRepo analyticsRepo;
int timeRangeIndex = 0;
Future<void> setTimeRangeIndex(int index)async {
    timeRangeIndex = index;
   await getAnalyticsData(limit: 10);
  }
 
  Future<void> getAnalyticsData({ required int limit}) async {
    emit(AnalyticsLoading());

    final productsResult = await analyticsRepo.getMostSoldProducts(
      timeRangeIndex: timeRangeIndex,
      limit: limit,
    );

    final ordersResult = await analyticsRepo.getOrdersOverTimeRange(
      timeRangeIndex: timeRangeIndex,
    );



    // ✅ البيانات موجودة
    final mostSoldProducts = productsResult.getOrElse(() => []);
    final ordersOver = ordersResult.getOrElse(() => []);

    emit(AnalyticsLoaded(
      mostSoldProducts: mostSoldProducts,
      ordersOver: ordersOver,
    ));
        // ✅ تحقق من الفشل
    if (productsResult.isLeft() || ordersResult.isLeft()) {
      final message = productsResult.fold(
        (l) => l.message,
        (r) => null,
      ) ??
          ordersResult.fold(
            (l) => l.message,
            (r) => null,
          );

      emit(AnalyticsError(message: message ?? 'Unexpected error'));
      return;
    }
  }
}
