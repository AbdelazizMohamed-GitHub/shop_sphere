import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeThemeLoading extends AppState {}


final class AppChangeThemeDark extends AppState {}

final class AppChangeThemeLight extends AppState {}

