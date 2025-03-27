import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final FirestoreService firestoreService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ProfileRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, UserEntity>> getUserData() async {
    try {
      UserEntity data = await firestoreService.getUserData(
          collection: "users", did: _firebaseAuth.currentUser!.uid);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> updateUserData(
      UserModel userModel) async {
    try {
      await firestoreService.updateData(
          collection: "users",
          did: _firebaseAuth.currentUser!.uid,
          data: userModel);
      await firestoreService.getUserData(
          collection: "users", did: _firebaseAuth.currentUser!.uid);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure( message: e.toString(),));
    }
  }
}
