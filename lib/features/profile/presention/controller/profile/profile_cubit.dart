import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/profile/domain/repo/profile_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());
  final ProfileRepo profileRepo;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    final result = await profileRepo.getUserData();
    result.fold(
      (failure) => emit(GetUserDataFailure(errMessage: failure.message)),
      (user) => emit(GetUserDataSuccess(user: user)),
    );
  }

  Future<void> updateUserData(UserModel userModel) async {
    emit(EditProfileLoading());
    final result = await profileRepo.updateUserData(userModel);
    result.fold(
      (failure) => emit(EditProfileFailure(errMessage: failure.message)),
      (user) => emit(EditProfileSuccess()),
    );
  }
}
