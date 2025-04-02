import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/explor/domain/repo/favourite_repo.dart';

class FavouriteRepoImpl extends FavouriteRepo {
  final FirestoreService firestoreService;

  FavouriteRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, void>> addToFavorite(
      {required String productId}) async {
    try {
      await firestoreService.addToFavorite(productId: productId);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, List<String>>> isFavoriteExit(
      {required String productId}) async {
    try {
      var data = await firestoreService.isFavoriteExist(productId: productId);
      return right(data
      );
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  
  
}
