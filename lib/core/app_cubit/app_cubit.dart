

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/app_cubit/app_state.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(
   {required this.authRepo} 
  ) : super(AppInitial());
  final AuthRepo authRepo;
  void changeTheme(context) {
    emit(AppChangeThemeLoading());
    if (AppTheme.isLightTheme(context)) {
      emit(AppChangeThemeDark());
    } else {
      emit(AppChangeThemeLight());
    }
  }

  
Future<void> getuserData() async {
    emit(GetUserDataLoading());
    final result = await authRepo.getUserData();
    result.fold(
      (failure) => emit(GetUserDataFailure(errMessage: failure.message)),
      (user) => emit(GetUserDataSucess(user: user)),
    );
  }
 

  

}
