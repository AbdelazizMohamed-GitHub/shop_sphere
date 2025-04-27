import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/notification_service.dart';
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
  Future<Either<FirebaseFailure, String>> registerWithEmailAndPassword(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password,
      required DateTime birthDate,
      required String gender}) async {
    UserCredential? userCredential;
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String token = (await NotificationService.getToken()) ?? '';
      await firestoreService.addData(
          collection: "users",
          did: userCredential.user!.uid,
          data: UserModel(
            fcmToken: token,
            isStaff: false,
            favProduct: [],
            birthDate: birthDate,
            email: email,
            gender: gender,
            name: name,
            phoneNumber: phoneNumber,
            createdAt: DateTime.now(),
            addressIndex: 0,
            uid: userCredential.user!.uid,
            profileImage: '',
          ));
      await userCredential.user?.sendEmailVerification();

      return Right(userCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (userCredential!.user != null) {
        await userCredential.user!.delete();
      }
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> logInWithEmailAndPassword(
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
        return Left(FirebaseFailure(
          message: "Email not verified",
        ));
      }
      return Right(user.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> logInWithGoogle() async {
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
        final uid = userCredential.user!.uid;

        // 🔍 Check if user document exists
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection("users").doc(uid).get();

        if (userDoc.data() == null) {
          // 🆕 Create new user document
          await firestoreService.addData(
            collection: "users",
            did: uid,
            data: UserModel(
              fcmToken: NotificationService.getToken().toString(),
              isStaff: false,
              email: userCredential.user!.email!,
              name: userCredential.user!.displayName ?? "",
              phoneNumber: userCredential.user!.phoneNumber ?? "",
              createdAt: DateTime.now(),
              addressIndex: 0,
              uid: uid,
              profileImage: '',
              birthDate: userCredential.user!.metadata.creationTime!,
              gender: '',
              favProduct: [],
            ),
          );
        }
      }
      UserEntity data = await firestoreService.getUserData();
      if (data.isStaff) {
        return const Right('Staff');
      }
      return const Right("Logged in successfully");
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> verifiyEmaill() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          return const Right("Email is verified ✅");
        } else {
          await user.sendEmailVerification();
          return Left(FirebaseFailure(
              message: "Verification email sent. Please check your inbox."));
        }
      } else {
        return Left(FirebaseFailure(
          message: "User not found",
        ));
      }
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isSignedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user == null ? false : true;
  }
}
