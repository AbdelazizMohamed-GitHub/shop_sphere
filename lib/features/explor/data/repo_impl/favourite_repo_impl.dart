import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/explor/domain/repo/favourite_repo.dart';

class FavouriteRepoImpl extends FavouriteRepo {
  final FirestoreService firestoreService;

  FavouriteRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, void>> addAndRemoveToFavorite(
      {required String productId}) async {
    try {
      await firestoreService.addAndRemoveToFavorite(productId: productId);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<FirebaseFailure, bool>> isFavoriteExit({required String productId})async {
  try {
  bool result =  await firestoreService.isFavoriteExit(productId: productId);
  return right(result);

  }on FirebaseException catch (e) {
    return Left(FirebaseFailure.fromCode(e.code));
  }
   catch (e) {
    return Left(FirebaseFailure(message: e.toString()));
  }
  }
}
