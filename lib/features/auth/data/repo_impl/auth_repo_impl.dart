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
      return Right(userCredential.user?.uid??"");
   }catch(e){
     return Left(Failure(e.toString()));
   }
  }

    @override
  Future<Either<Failure, String>> logInWithEmailAndPassword(String email, String password)async {
try {
    UserCredential user=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Right(user.user?.uid??"");
} catch (e) {
     return Left(Failure(e.toString()));
}

  }
  @override
  Future<bool> isSignedIn() async{
   

    User? user = _firebaseAuth.currentUser;
    return user==null?false:true;
  }
  @override
  Future<Either<Failure, String>> getUser() {
    // TODO: implement getUser
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