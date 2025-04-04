import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

abstract class CartRepo {
  Future<Either<FirebaseFailure, void>> addToCart({required CartItemModel cartItemModel});
  Future<Either<FirebaseFailure, void>> removeFromCart({required String productId});
  Future<Either<FirebaseFailure, void>> clearCart();
  Future<Either<FirebaseFailure, List<CartEntity>>> getAllProductsInCart();
  Future<Either<FirebaseFailure, void>> updateCartQuantity({required String productId,required bool isIncrement });
  Future<Either<FirebaseFailure, void>> updateCartQuantityWithCount({required String productId,required int count });
  Future<Either<FirebaseFailure, CartEntity?>> getProductInCart({required String productId});

}