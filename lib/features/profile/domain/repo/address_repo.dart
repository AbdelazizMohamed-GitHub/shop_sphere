import 'package:dartz/dartz.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

abstract class AddressRepo {
  Future<Either<FirebaseFailure, void>> addAddress(
      String addressId, AddressModel addressModel);
  Future<Either<FirebaseFailure, void>> updateAddress(
      String addressId, AddressModel addressModel);
  Future<Either<FirebaseFailure, void>> deleteAddress(String addressId);
  Future<Either<FirebaseFailure, List<AddressEntity>>> getAddress();
}
