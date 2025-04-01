import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class FavouriteRepo {
      Future<Either<FirebaseFailure, void>> addAndRemoveToFavorite({required String productId});
      Future<Either<FirebaseFailure, bool>> isFavoriteExit({required String productId});

} 