import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial()) {
    _setupGsiListener(); // ✅ شغل المستمع هنا عند الإنشاء
  }

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

  void logInWithEmailAndPassword({
    required String email,
    required String password,
    required context,
  }) async {
    emit(AuthLoading());
    final result = await authRepo.logInWithEmailAndPassword(email, password, context);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  /// ✅ للموبايل فقط
  void loginWithGoogle() async {
    if (kIsWeb) {
      print("⚠️ Google Sign-In عبر الزر فقط على الويب. استخدم GSI.");
      return;
    }

    emit(GoogleAuthLoading());
    final result = await authRepo.logInWithGoogle();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  /// ✅ يستخدم في Web فقط مع Google Identity Services
  void loginWithGoogleFromWeb(String idToken) async {
    emit(GoogleAuthLoading());
    final result = await authRepo.signInWithIdTokenFromWeb(idToken);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  /// ✅ مستمع GSI لـ Web
  void _setupGsiListener() {
    if (kIsWeb) {
      html.window.addEventListener('googleSignInSuccess', (event) {
        final idToken = (event as html.CustomEvent).detail;
        loginWithGoogleFromWeb(idToken);
      });
    }
  }

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
