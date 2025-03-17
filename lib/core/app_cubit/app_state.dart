import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeThemeLoading extends AppState {}


final class AppChangeThemeDark extends AppState {}

final class AppChangeThemeLight extends AppState {}
final class GetUserDataLoading extends AppState {}

final class GetUserDataSucess extends AppState {
  final UserEntity user;

  GetUserDataSucess({required this.user});
}

final class GetUserDataFailure extends AppState {
  final String errMessage;

  GetUserDataFailure({required this.errMessage});
}
