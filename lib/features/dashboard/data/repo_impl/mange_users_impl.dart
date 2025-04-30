import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/mange_users.dart';

class MangeUsersImpl extends MangeUsers {
   @override
  Future<Either<FirebaseFailure, List<UserEntity>>> getUsers({required bool isStaff}) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
  @override
  Future<void> deleteUser({required String userId}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

 
}