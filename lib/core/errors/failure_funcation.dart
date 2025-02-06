import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/core/errors/auth_failure.dart';

class FailureFuncation {
static void authError(Object e) {
    e is FirebaseAuthException
        ?  Left(AuthFailure.fromCode(e.code))
        :  Left(AuthFailure('An unknown error occurred'));
  }
  
}