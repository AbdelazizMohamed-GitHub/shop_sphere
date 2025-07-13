part of 'analytics_cubit.dart';

sealed class AnalyticsState extends Equatable {
  final List<ProductMostSellerModel> mostSoldProducts;
  final List<OrderOverModel> ordersOver;


  const AnalyticsState(
      {required this.mostSoldProducts, required this.ordersOver, });

  @override
  List<Object> get props => [
        mostSoldProducts,
        ordersOver,
      ];
}

final class AnalyticsInitial extends AnalyticsState {
  AnalyticsInitial() : super(mostSoldProducts: [], ordersOver: []);
}
final class AnalyticsLoading extends AnalyticsState {
   AnalyticsLoading():super(
    mostSoldProducts: [],
    ordersOver: [],
  );
}
final class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded({
    required super.mostSoldProducts,
    required super.ordersOver,
    
  });
}
final class AnalyticsError extends AnalyticsState {
  final String message;
   AnalyticsError({required this.message}):super(
    mostSoldProducts: [],
    ordersOver: [],
  );
}
