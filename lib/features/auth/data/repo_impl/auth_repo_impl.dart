import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_sphere/core/errors/auth_failure.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/core/errors/failure_funcation.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<Either<Failure, String>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.sendEmailVerification();
      return Right(userCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logInWithEmailAndPassword(
      String email, String password,context) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
if (!user.user!.emailVerified) {
  user.user?.sendEmailVerification();
  Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyScreen(email: user.user!.email!,),));
        return Left(AuthFailure("Email not verified"));
    
  
}
      return Right(user.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logInWithGoogle() async {
     try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          print('Signed in: ${user.displayName}');
        }
      }
      return Right("logged in");
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifiyEmaill() async {
    try {
      User? user = _firebaseAuth.currentUser;
      
     
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
     
      return const Right("Email Sent");
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<bool> isSignedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user == null ? false : true;
  }

  @override
  @override
  Future<Either<Failure, String>> getUser() {
    throw UnimplementedError();
  }
}
