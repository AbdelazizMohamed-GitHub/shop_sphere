import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

abstract class UserRepo {
  Future<Either<FirebaseFailure, UserEntity>> getUserData();
  Future<Either<FirebaseFailure, void>> updateUserData(UserModel userModel);
}
