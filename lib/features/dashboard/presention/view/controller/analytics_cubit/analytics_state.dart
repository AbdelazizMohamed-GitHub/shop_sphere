abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final double rangeTotal;
  final List<int> days;
  final List<String> products; 

  AnalyticsLoaded({
    required this.products,
    required this.rangeTotal,
    required this.days,
  });
}

class AnalyticsError extends AnalyticsState {
  final String errMessage;

  AnalyticsError({required this.errMessage});
}

class AnalyticsTimeRangeLoading extends AnalyticsState {}
class AnalyticsTimeRangeLoaded extends AnalyticsState {
  final double rangeTotal;

  AnalyticsTimeRangeLoaded({required this.rangeTotal});
}
