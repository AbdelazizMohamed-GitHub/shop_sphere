
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeThemeLoading extends AppState {}

final class AppChangeThemeDark extends AppState {
  AppChangeThemeDark();
}final class AppChangeThemeLight extends AppState {
  AppChangeThemeLight();
}
