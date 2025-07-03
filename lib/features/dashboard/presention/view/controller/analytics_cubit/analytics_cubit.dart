import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/analytics_repo.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({required this.analyticsRepo}) : super(AnalyticsInitial());

  final AnalyticsRepo analyticsRepo;
  int timeRangeIndex = 0;
  void changeTimeRange(int index) {
    timeRangeIndex = index;
  }

  Future<void> getAllAnalyticsData({required int timeRangeIndex}) async {
    emit(AnalyticsLoading());
    changeTimeRange(timeRangeIndex);

    final rangeResult = await analyticsRepo.getOrdersTotalPriceTimeRange(
        timeRangeIndex: timeRangeIndex);
    final dayResult = await analyticsRepo.getDayOrdersTotalPrice();

    if (rangeResult.isLeft()) {
      emit(AnalyticsError(
          errMessage: rangeResult.fold((l) => l.message, (r) => "Unknown")));
      return;
    }

    if (dayResult.isLeft()) {
      emit(AnalyticsError(
          errMessage: rangeResult.fold((l) => l.message, (r) => "Unknown")));
      return;
    }

    final rangeTotal = rangeResult.getOrElse(() => 0);
    final days = dayResult.getOrElse(() => []);

    emit(AnalyticsLoaded(rangeTotal: rangeTotal, days: days));
  }
  Future<void> getTimeRangeData({required int timeRangeIndex}) async {
    emit(AnalyticsLoading());
    changeTimeRange(timeRangeIndex);

    final rangeResult = await analyticsRepo.getOrdersTotalPriceTimeRange(
        timeRangeIndex: timeRangeIndex);

    rangeResult.fold(
      (l) {
        emit(AnalyticsError(errMessage: l.message));
      },
      (r) {
emit(AnalyticsTimeRangeLoaded(rangeTotal: r));
      },
    );
    
  }


}
