import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/notification_service.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/repo/auth_repo.dart';

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
      String? token = await NotificationService.getToken();
      FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await firestoreService.addData(
          collection: "users",
          did: userCredential.user!.uid,
          data: UserModel(
            fcmToken: token.toString(),
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
      FirebaseAuth.instance.currentUser?.updateProfile(
        displayName: name,
      );
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
    print("🔐 Trying to sign in with: $email");

    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print("✅ Firebase login successful, UID: ${user.user?.uid}");

    final data = await firestoreService.getUserData();
    print("📄 User Data Fetched: ${data.toString()}");

    if (data.isStaff) {
      print("👔 User is staff");
      return const Right('Staff');
    }

    return Right(user.user?.uid ?? "");
  } on FirebaseAuthException catch (e) {
    print('❌ FirebaseAuthException => Code: ${e.code} | Message: ${e.message}');
    return Left(FirebaseFailure.fromCode(e.code));
  } catch (e) {
    print("🔥 Unknown error during login: $e");
    return Left(FirebaseFailure(message: e.toString()));
  }
}

  @override
  Future<Either<FirebaseFailure, String>> logInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      }

      // موبايل فقط
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(FirebaseFailure(message: 'Sign in aborted by user.'));
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return Left(FirebaseFailure(message: 'User not found after login.'));
      }

      final uid = user.uid;
      final token = await NotificationService.getToken() ?? '';

      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (!userDoc.exists) {
        await firestoreService.addData(
          collection: "users",
          did: uid,
          data: UserModel(
            uid: uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            phoneNumber: user.phoneNumber ?? '',
            profileImage: user.photoURL ?? '',
            birthDate: user.metadata.creationTime ?? DateTime.now(),
            gender: '',
            fcmToken: token,
            isStaff: false,
            addressIndex: 0,
            createdAt: DateTime.now(),
            favProduct: [],
          ),
        );
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set({'fcmToken': token}, SetOptions(merge: true));
      }

      final userData = await firestoreService.getUserData();
      if (userData.isStaff) {
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
  Future<Either<FirebaseFailure, String>> signInWithIdTokenFromWeb(
      String idToken) async {
    try {
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return Left(FirebaseFailure(message: 'User not found after login.'));
      }

      final uid = user.uid;
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      final token = await NotificationService.getToken() ?? '';

      if (!userDoc.exists) {
        await firestoreService.addData(
          collection: "users",
          did: uid,
          data: UserModel(
            uid: uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            phoneNumber: user.phoneNumber ?? '',
            profileImage: user.photoURL ?? '',
            birthDate: user.metadata.creationTime ?? DateTime.now(),
            gender: '',
            fcmToken: token,
            isStaff: false,
            addressIndex: 0,
            createdAt: DateTime.now(),
            favProduct: [],
          ),
        );
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set({'fcmToken': token}, SetOptions(merge: true));
      }

      final userData = await firestoreService.getUserData();
      if (userData.isStaff) {
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
  Future<bool> isSignedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user == null ? false : true;
  }
}
