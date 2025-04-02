import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

abstract class FavouriteRepo {
      Future<Either<FirebaseFailure, void>> addToFavorite({required String productId});
      Future<Either<FirebaseFailure, bool>> isFavoriteExit({required String productId});

} 