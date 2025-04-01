import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final FirestoreService firestoreService;
  ProductRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts() async {
    try {
    var data=  await firestoreService.getProduct();
    return right(data);
    }on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }
    catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  


}
