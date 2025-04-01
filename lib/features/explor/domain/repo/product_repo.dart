import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

abstract class ProductRepo {
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts();

}
