import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class AuthRepo {
  Future<Either<FirebaseFailure, String>> registerWithEmailAndPassword(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password,
      required DateTime birthDate,
      required String gender});

  Future<Either<FirebaseFailure, String>> logInWithEmailAndPassword(
      String email, String password, context);
  Future<Either<FirebaseFailure, String>> logInWithGoogle();
  Future<Either<FirebaseFailure, String>> verifiyEmaill();
  Future<Either<FirebaseFailure, void>> resetPassword(String email);
  
  Future<bool> isSignedIn();
}
