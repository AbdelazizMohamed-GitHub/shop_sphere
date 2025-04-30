import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/mange_users_repo.dart';

class MangeUsersImpl extends MangeUsersRepo {
  final FirestoreService firestoreService;
  MangeUsersImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, List<UserEntity>>> getUsers(
      {required bool isStaff}) async {
    try {
      List<UserEntity> users = await firestoreService.getUsers(isStaff: isStaff);
      return Right(users);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
      }
  @override
  Future<void> deleteUser({required String userId}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
