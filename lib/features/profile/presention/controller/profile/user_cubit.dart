import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/profile/domain/repo/profile_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepo}) : super(ProfileInitial());
  final UserRepo userRepo;
  Future<void> getUserData() async {
    emit(UserLoading());
    final result = await userRepo.getUserData();
    result.fold(
      (failure) =>
          emit(UserFailure(errMessage: failure.message)),
      (user) => emit(UserSuccess(user: user)),
    );
  }

  Future<void> updateUserData(UserModel userModel) async {
    emit(UserLoading());
    final result = await userRepo.updateUserData(userModel);
    result.fold(
      (failure) =>
          emit(UserFailure(errMessage: failure.message)),
      (user) {
       
        getUserData();
 
      },
    );
    
    
  }

 
}
