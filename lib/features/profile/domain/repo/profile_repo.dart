import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, void>> updateUserData(UserModel userModel);
  

}