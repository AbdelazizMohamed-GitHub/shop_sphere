import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

abstract class MangeUsersRepo {
  Future<Either<FirebaseFailure,List<UserEntity>>> getUsers({required bool isStaff});
  Future<void> deleteUser({required String userId});
  
}