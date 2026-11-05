import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashboardState extends Equatable {
  final int screenIndex;
  const DashboardState({this.screenIndex = 0});
  @override
  List<Object?> get props => [screenIndex];
}
  
class DashboardChangeScreenIndex extends DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final List<ProductEntity> products;

  const DashboardSuccess({required this.products});
}

class DashboardFailure extends DashboardState {
  final String errMessage;
  const DashboardFailure({required this.errMessage});
}
