import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> registerWithEmailAndPassword(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password,
      required DateTime birthDate,
      required String gender}) async {
    emit(AuthLoading());
    final result = await authRepo.registerWithEmailAndPassword(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        birthDate: birthDate,
        gender: gender);
    result.fold(
      (firebaseFailure) => emit(AuthError(firebaseFailure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }

  void logInWithEmailAndPassword(
      {required String password,
      required String email,
      required context}) async {
    emit(AuthLoading());
    final result =
        await authRepo.logInWithEmailAndPassword(email, password, context);
    result.fold(
      (firebaseFailure) => emit(AuthError(firebaseFailure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }

  void loginWithGoogle() async {
    emit(GoogleAuthLoading());
    final result = await authRepo.logInWithGoogle();
    result.fold(
      (firebaseFailure) => emit(AuthError(firebaseFailure.message)),
      (uid) => emit(AuthSuccess()),
    );
  }

  void resetPassword({required String email}) async {
    emit(ResetPassword());
    final result = await authRepo.resetPassword(email);
    result.fold(
      (firebaseFailure) => emit(AuthError(firebaseFailure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> verifiyEmaill() async {
    emit(AuthLoading());
    final result = await authRepo.verifiyEmaill();
    result.fold(
      (firebaseFailure) => emit(AuthError(firebaseFailure.message)),
      (massge) => emit(AuthVerifiy(massge)),
    );
  }
}
