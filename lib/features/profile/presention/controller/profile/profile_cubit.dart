

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_state.dart';



class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit( {required this.authRepo}) : super(ProfileInitial());
   final AuthRepo authRepo;
 Future <void> getUserData()async {
    emit(GetUserDataLoading());
    final result = await authRepo.getUserData();
    result.fold(
      (failure) => emit(GetUserDataFailure(errMessage: failure.message)),
      (user) => emit(GetUserDataSucess(user: user)),
    );
  }
}
