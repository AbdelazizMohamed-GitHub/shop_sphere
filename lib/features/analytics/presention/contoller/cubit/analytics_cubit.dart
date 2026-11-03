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

  // Keeps the last selected range during the app session.
  // This prevents the selection from resetting to `0` if the Cubit is recreated
  // (for example after a refresh/build).
  static int _savedTimeRangeIndex = 0;

  int timeRangeIndex = _savedTimeRangeIndex;

  Future<void> setTimeRangeIndex(int index) async {
    timeRangeIndex = index;
    _savedTimeRangeIndex = index;
    await getAnalyticsData(limit: 10);
  }

  Future<void> getAnalyticsData({required int limit}) async {
    emit(AnalyticsLoading());

    final productsFuture = analyticsRepo.getMostSoldProducts(
      timeRangeIndex: timeRangeIndex,
      limit: limit,
    );
    final ordersFuture = analyticsRepo.getOrdersOverTimeRange(
      timeRangeIndex: timeRangeIndex,
    );

    final productsResult = await productsFuture;
    final ordersResult = await ordersFuture;

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

    emit(AnalyticsLoaded(
      mostSoldProducts: productsResult.getOrElse(() => []),
      ordersOver: ordersResult.getOrElse(() => []),
    ));
  }
}
