import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime birthDate,
    required String gender,
  }) async {
    emit(AuthLoading());
    final result = await authRepo.registerWithEmailAndPassword(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      birthDate: birthDate,
      gender: gender,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
    required context,
  }) async {
    emit(AuthLoading());
    final result =
        await authRepo.logInWithEmailAndPassword(email, password, context);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  /// ✅ للموبايل فقط
  Future<void> loginWithGoogle() async {
    
    emit(GoogleAuthLoading());
    final result = await authRepo.logInWithGoogle();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  /// ✅ يستخدم في Web فقط مع Google Identity Services
  

  /// ✅ مستمع GSI لـ Web

  void resetPassword({required String email}) async {
    emit(AuthLoading());
    final result = await authRepo.resetPassword(email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(ResetPassword()),
    );
  }

  Future<void> verifiyEmaill() async {
    emit(AuthLoading());
    final result = await authRepo.verifiyEmaill();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (msg) => emit(AuthVerifiy(msg)),
    );
  }
}
