// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/user_service.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/address_repo.dart';

class AddressRepoImpl extends AddressRepo {
  UserService userService;
  AddressRepoImpl({
    required this.userService,
  });
  @override
  Future<Either<FirebaseFailure, void>> addAddress(
      String addressId, AddressModel addressModel) async {
    try {
      await userService.addAddress(
          addressId: addressId, adress: addressModel);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }@override
  Future<Either<FirebaseFailure, void>> updateAddress(String addressId, AddressModel addressModel)async {
   try {
     await userService.updateAddress(addressId: addressId, adress: addressModel);
    return right(null); 
   }on FirebaseException catch (e) {
     return Left(FirebaseFailure.fromCode(e.code));
   }
    catch (e) {
     return Left(FirebaseFailure(message: e.toString()));
   }
  }
  
  @override
  Future<Either<FirebaseFailure, void>> deleteAddress(String addressId)async {
   try {
     await userService.deleteAddress(addressId: addressId);
    return right(null);
   } on FirebaseException catch (e) {
     return Left(FirebaseFailure.fromCode(e.code));
   }
   catch (e) {
     return Left(FirebaseFailure(message: e.toString()));
   }
  }
  
  @override
  Future<Either<FirebaseFailure, List<AddressEntity>>> getAddress() async{
    try {
     var data =await userService.getAddress();
return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<AddressEntity>>> getCustomerAddresses(
      {required String userId}) async {
    try {
      final data = await userService.getCustomerAddresses(userId: userId);
      return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<FirebaseFailure, void>> updateAddressIndex({required int sellectAddress})async {
    try {
     await userService.updateAddressIndex(sellectAddressIndex: sellectAddress);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  
}
