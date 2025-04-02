import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

abstract class CartRepo {
  Future<Either<FirebaseFailure, void>> addToCart({required String productId});
  Future<Either<FirebaseFailure, void>> removeFromCart({required String productId});
  Future<Either<FirebaseFailure, void>> clearCart();
  Future<Either<FirebaseFailure, bool>> isProductInCart({required String productId});
  Future<Either<FirebaseFailure, List<ProductEntity>>> getAllProductsInCart();
}