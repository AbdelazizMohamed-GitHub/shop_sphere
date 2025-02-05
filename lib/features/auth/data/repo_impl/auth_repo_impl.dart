import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    @override
  Future<Either<Failure, String>> registerWithEmailAndPassword(String email, String password)async {
   try{
     UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user?.uid??"1");
   }catch(e){
     return Left(Failure(e.toString()));
   }
  }
  @override
  Future<Either<Failure, String>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logInWithEmailAndPassword(String email, String password) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, void>> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}