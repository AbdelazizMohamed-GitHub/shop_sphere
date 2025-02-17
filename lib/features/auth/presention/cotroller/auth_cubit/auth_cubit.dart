import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(  {required this.authRepo }) : super(AuthInitial()) ;
final AuthRepo authRepo;
  Future<void> registerWithEmailAndPassword({required String password, required String email}) async {
    emit(AuthLoading());
    final result = await authRepo.registerWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess()),
     
    );
  }
    void logInWithEmailAndPassword({required String password, required String email}) async {
    emit(AuthLoading());
    final result = await authRepo.logInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }
  void loginWithGoogle() async {
    emit(AuthLoading());
    final result = await authRepo.logInWithGoogle();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }
  void resetPassword({required String email}) async {
    emit(AuthLoading());
    final result = await authRepo.resetPassword(email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }
 Future< void> verifiyEmaill() async {
    emit(AuthLoading());
    final result = await authRepo.verifiyEmaill();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (massge) => emit(AuthVerifiy(massge)),
    );
  }
}