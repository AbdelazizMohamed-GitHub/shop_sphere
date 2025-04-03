import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class FavouriteRepo {
      Future<Either<FirebaseFailure, void>> addToFavorite({required String productId});
      Future<Either<FirebaseFailure, List<String>>> isFavoriteExit({required String productId});

} 