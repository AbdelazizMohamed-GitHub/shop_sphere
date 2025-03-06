import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_state.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void changeTheme(context) {
    emit(AppChangeThemeLoading());
    if (AppTheme.isLightTheme(context)) {
      emit(AppChangeThemeDark());
    } else  {
      emit(AppChangeThemeLight());
    }
  }
}
