abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final double rangeTotal;
  final List days;

  AnalyticsLoaded({
    required this.rangeTotal,
    required this.days,
  });
}

class AnalyticsError extends AnalyticsState {
  final String errMessage;

  AnalyticsError({required this.errMessage});
}
