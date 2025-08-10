import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

abstract class DashboardRepo {
  Future<Either<FirebaseFailure, String>> addProduct({
    required ProductModel product,
    required Uint8List imageFile
   
  });
  
  Future<Either<FirebaseFailure, List<ProductEntity>>> getProducts({required String category});
  
  Future<Either<FirebaseFailure, String>> deleteProduct({required String dId,required String imageUrl});
  
  Future<Either<FirebaseFailure, String>> updateProduct({ required ProductModel data});

}
