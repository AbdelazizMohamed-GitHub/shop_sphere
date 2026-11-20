import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/product_service.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductService productService;
  ProductRepoImpl({required this.productService});
  @override
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts({required String category}) async {
    try {
    var data=  await productService.getProducts(category: category);

    return right(data);
    }on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<ProductEntity>>>  getPopularProducts({required String category})async{
    try {
      var data=  await productService.getPopularProducts(category: category);

      return right(data);
    }on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  


}
