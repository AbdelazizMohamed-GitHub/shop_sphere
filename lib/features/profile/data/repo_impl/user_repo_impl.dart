import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/user_service.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserService userService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserRepoImpl({required this.userService});
  @override
  Future<Either<FirebaseFailure, UserEntity>> getUserData() async {
    try {
     
      UserEntity data = await userService.getUserData(
      );
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
    if (!await AppFuncations.isOnline() ) {
      return Left(FirebaseFailure(message: "No Internet Connection"));
    }
    try {
      await userService.updateData(
          collection: "users",
          did: _firebaseAuth.currentUser!.uid,
          data: userModel);
      await userService.getUserData(
         );
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure( message: e.toString(),));
    }
  }
}
