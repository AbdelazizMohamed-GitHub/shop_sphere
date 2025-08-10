// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart'
    show ProductEntity;

class DashboardRepoImpl extends DashboardRepo {
  FirestoreService firestoreService;
  DashboardRepoImpl({
    required this.firestoreService,
  });

  @override
  Future<Either<FirebaseFailure, String>> addProduct({
    required Uint8List imageFile,
    required ProductModel product,
  }) async {
    try {
      await firestoreService.addProduct(data: product, image: imageFile);
      return const Right('Product added successfully');
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    } catch (e) {
      // Handle other exceptions

      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts({required String category}) async {
    try {
      var result = await firestoreService.gettProducts(category: category);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> deleteProduct(
      {required String dId, required String imageUrl}) async {
    try {
      await firestoreService.deleteProduct(dId: dId, imageUrl: imageUrl);

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
      await firestoreService.updateProduct(dId: data.pId, data: data);
      return const Right('Product updated successfully');
    } on FirebaseException catch (e) {
      return Left((FirebaseFailure.fromCode(e.code)));
    } catch (e) {
      return Left((FirebaseFailure.fromCode(e.toString())));
    }
  }
}
