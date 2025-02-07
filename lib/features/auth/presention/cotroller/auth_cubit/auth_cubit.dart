import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(  {required this.authRepo }) : super(AuthInitial()) ;
final AuthRepo authRepo;
  void registerWithEmailAndPassword({required String password, required String email}) async {
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
}