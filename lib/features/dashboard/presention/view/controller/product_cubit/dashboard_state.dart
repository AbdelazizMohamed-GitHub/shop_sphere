import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
   final List<ProductEntity> products;
  DashboardSuccess({required this.products});

}

class DashboardFailer extends DashboardState {
final  String errMessage;
  DashboardFailer({required this.errMessage});
}

