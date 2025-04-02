import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/cart_repo.dart';

class CartRepoImpl extends CartRepo {
   final FirestoreService firestoreService;

  CartRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, void>> addToCart({required String productId})async {
    try {
    var data =  await firestoreService.addToCart(productId: productId);
      return Right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
    }
    
      @override
      Future<Either<FirebaseFailure, void>> clearCart()async {
   try {
     await firestoreService.clearCart();
     return const Right(null);
   }on FirebaseException catch (e) {
     return Left(FirebaseFailure.fromCode(e.code));
   } 
   catch (e) {
     return Left(FirebaseFailure(message: e.toString()));
     
   }
      }
    
      @override
      Future<Either<FirebaseFailure, List<ProductEntity>>> getAllProductsInCart()async {
    try {
      var data =  await firestoreService.getAllProductsInCart();
      return Right(data);
    }on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } 
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
      } 
    
      @override
      Future<Either<FirebaseFailure, bool>> isProductInCart({required String productId})async {
    try {
      var data =  await firestoreService.isProductInCart(productId: productId);
      return Right(data);
    }on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } 
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
      }
    
      @override
      Future<Either<FirebaseFailure, void>> removeFromCart({required String productId})async {
    try {
      await firestoreService.addToCart(productId: productId);
      return const Right(null);
    }
    on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } 
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
      }
    
}
