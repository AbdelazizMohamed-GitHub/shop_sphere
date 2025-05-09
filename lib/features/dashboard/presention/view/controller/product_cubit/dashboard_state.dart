import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
    DashboardSuccess();

}

class DashboardFailer extends DashboardState {
final  String errMessage;
  DashboardFailer({required this.errMessage});
}

