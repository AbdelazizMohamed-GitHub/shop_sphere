// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/domain/repo/address_repo.dart';

class AddressRepoImpl extends AddressRepo {
  FirestoreService firestoreService;
  AddressRepoImpl({
    required this.firestoreService,
  });
  @override
  Future<Either<FirebaseFailure, void>> addAddress(
      String addressId, AddressModel addressModel) async {
    try {
      await firestoreService.addAddress(
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
     await firestoreService.updateAddress(addressId: addressId, adress: addressModel);
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
     await firestoreService.deleteAddress(addressId: addressId);
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
     var data =await firestoreService.getAddress();
return right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<FirebaseFailure, void>> updateAddressIndex({required int sellectAddress})async {
    try {
     await firestoreService.updateAddressIndex(sellectAddressIndex: sellectAddress);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  
}
