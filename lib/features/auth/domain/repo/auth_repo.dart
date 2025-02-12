import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> registerWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, String>> logInWithEmailAndPassword(
      String email, String password);
      Future<Either<Failure, String>> logInWithGoogle();
      Future<Either<Failure, String>> verifiyEmaill();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> signOut();
  Future<bool> isSignedIn();
  Future<Either<Failure, String>> getUser();
}
