import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit {
  AuthCubit(super.initialState, this.authRepo);
final AuthRepo authRepo;
  void registerWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.registerWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }
}