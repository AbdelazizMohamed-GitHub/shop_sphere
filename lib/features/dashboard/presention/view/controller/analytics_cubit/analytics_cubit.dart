import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/analytics_repo.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({required this.analyticsRepo}) : super(AnalyticsInitial());

  final AnalyticsRepo analyticsRepo;

  Future<void> getAllAnalyticsData({required int timeRangeIndex}) async {
    emit(AnalyticsLoading());

    final rangeResult = await analyticsRepo.getOrdersTotalPriceTimeRange(
        timeRangeIndex: timeRangeIndex);
    final dayResult = await analyticsRepo.getDayOrdersTotalPrice();

    if (rangeResult.isLeft()) {
      emit(AnalyticsError(
          errMessage: rangeResult.fold((l) => l.message, (r) => "Unknown")));
      return;
    }

    if (dayResult.isLeft()) {
      emit(AnalyticsError(errMessage: rangeResult.fold((l) => l.message, (r) => "Unknown")));
      return;
    }

    final rangeTotal = rangeResult.getOrElse(() => 0);
    final days = dayResult.getOrElse(() => []);

    emit(AnalyticsLoaded(rangeTotal: rangeTotal, days: days));
  }
}
