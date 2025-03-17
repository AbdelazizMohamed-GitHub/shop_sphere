import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shop_sphere/core/errors/auth_failure.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/verify_screen.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirestoreService firestoreService;
  AuthRepoImpl({
    required this.firestoreService,
  });

  @override
  Future<Either<Failure, String>> registerWithEmailAndPassword(
     {required String name,required String phoneNumber,
     required String email,required String password,required DateTime
      birthDate,required String gender}
      ) async {
    UserCredential? userCredential;
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firestoreService.addData(
          collection: "users",
          did: userCredential.user!.uid,
          data: UserModel(
            birthDate:birthDate,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
            address: [],
            createdAt: DateTime.now(),
            addressIndex: 0,
            uid: userCredential.user!.uid,
            profileImage: '',
            orderHistory: [],
          ));
      await userCredential.user?.sendEmailVerification();

      return Right(userCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (userCredential!.user != null) {
        await userCredential.user!.delete();
      }
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logInWithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!user.user!.emailVerified) {
        user.user?.sendEmailVerification();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyScreen(
                email: user.user!.email!,
              ),
            ));
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
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        var userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        await firestoreService.addData(
            collection: "users",
            did: userCredential.user!.uid,
            data: UserModel(
              email: userCredential.user!.email!,
              name: userCredential.user!.displayName ?? "",
              phoneNumber: userCredential.user!.phoneNumber ?? "",
              address: [],
              createdAt: DateTime.now(),
              addressIndex: 0,
              uid: userCredential.user!.uid,
              profileImage: '',
              orderHistory: [],
              birthDate: userCredential.user!.metadata.creationTime!,
            ));
      }
      return const Right(" Logged in successfully");
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

      if (user != null) {
        if (user.emailVerified) {
          return const Right("Email is verified ✅");
        } else {
          await user.sendEmailVerification();
          return Left(
              AuthFailure("Verification email sent. Please check your inbox."));
        }
      } else {
        return Left(AuthFailure("User not found"));
      }
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
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {UserEntity data=  await firestoreService.getData(collection: "users", did: _firebaseAuth.currentUser!.uid);
    return right(data);} 
      on FirebaseException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
    
    }
  }

