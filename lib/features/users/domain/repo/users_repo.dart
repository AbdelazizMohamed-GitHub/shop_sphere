import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

abstract class UsersRepo {
  Future<Either<FirebaseFailure,List<UserEntity>>> getUsers({required bool isStaff});
  Future<Either<FirebaseFailure,List<ProductEntity>>> getStaffProducts({required String staffId});

  Future<void> deleteUser({required String userId});
  
}