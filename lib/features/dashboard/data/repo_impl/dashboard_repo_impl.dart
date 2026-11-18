import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/product_service.dart';

import 'package:shop_sphere/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart'
    show ProductEntity;

class DashboardRepoImpl extends DashboardRepo {
  ProductService productService;
  DashboardRepoImpl({
    required this.productService,
  });

  @override
  Future<Either<FirebaseFailure, String>> addProduct({
    required Uint8List imageFile,
    required ProductModel product,
  }) async {
    try {
      await productService.addProduct(data: product, image: imageFile);
      return const Right('Product added successfully');
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    } catch (e) {
      // Handle other exceptions

      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts(
      {required String category}) async {
    try {
      var result = await productService.getProducts(category: category);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> deleteProduct(
      {required String dId, required String imageUrl}) async {
    try {
      await productService.deleteProduct(dId: dId, imageUrl: imageUrl);

      return const Right('Product deleted successfully');
    } on FirebaseException catch (e) {
      

      return Left((FirebaseFailure.fromCode(e.code)));
    } catch (e) {
      return Left((FirebaseFailure.fromCode(e.toString())));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> updateProduct(
      {required ProductModel data}) async {
    try {
      await productService.updateProduct(dId: data.pId, data: data);
      return const Right('Product updated successfully');
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    } catch (e) {
      return Left((FirebaseFailure.fromCode(e.toString())));
    }
  }
}
