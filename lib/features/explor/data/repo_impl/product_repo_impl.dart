import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/failure.dart';
import 'package:shop_sphere/core/test_data/test_product.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() {
 try {
    return Future.value(right(dummyProducts));
 } catch (e) {
   return Future.value(left(Failure( message: 'e.toString()')));
   
 }
  }
}
