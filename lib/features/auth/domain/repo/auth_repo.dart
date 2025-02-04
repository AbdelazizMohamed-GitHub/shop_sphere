import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/failure.dart';

abstract class AuthRepo{
  Future<Either<Failure ,void>> logInWithEmailAndPassword(String email, String password);
  Future<Either<Failure , void>> registerWithEmailAndPassword(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<bool> isSignedIn();
  Future<Either<Failure, String>> getUser();
}