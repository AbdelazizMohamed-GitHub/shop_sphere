import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  Future<Either<Failure, String>> logInWithGoogle() async{
    
 try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return Left(Failure("Google Sign-In Failed")); // If user cancels

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credential
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return Right(userCredential.user?.uid??"");
    } catch (e) {
      return Left(Failure(e.toString()));
    }  }
     @override
  Future<Either<Failure, String>> verifiyEmaill(String email)async {
    try {
    await  _firebaseAuth.currentUser?.sendEmailVerification();
    return const Right("Email Sent");
    } catch (e) {
     return Left(Failure(e.toString()));
    }
    }
  
  @override
  Future<Either<Failure, void>> resetPassword(String email) async{
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right( null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> signOut()async {
   await _firebaseAuth.signOut();
    throw UnimplementedError();
  }
  @override
  Future<bool> isSignedIn() async{
   

    User? user = _firebaseAuth.currentUser;
    return user==null?false:true;
  }
   @override
  
  
  @override
  Future<Either<Failure, String>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
 
 

 }
 






 

