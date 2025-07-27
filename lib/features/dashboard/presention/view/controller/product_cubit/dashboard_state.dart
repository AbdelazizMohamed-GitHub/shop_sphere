import 'package:equatable/equatable.dart';

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
    const DashboardSuccess();

}

class DashboardFailer extends DashboardState {
final  String errMessage;
  const DashboardFailer({required this.errMessage});
}

