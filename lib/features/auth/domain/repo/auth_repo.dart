import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> registerWithEmailAndPassword(
    {required String name,required String phoneNumber, required  String email,required String password,required DateTime birthDate,required String gender}
     );

  Future<Either<Failure, String>> logInWithEmailAndPassword(
      String email, String password,context);
      Future<Either<Failure, String>> logInWithGoogle();
      Future<Either<Failure, String>> verifiyEmaill();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> signOut();
  Future<bool> isSignedIn();
  Future<Either<Failure, UserEntity>> getUserData();
}
