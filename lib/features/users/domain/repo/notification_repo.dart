import 'package:dartz/dartz.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

abstract class NotificationRepo {
  Future<Either<FirebaseFailure, void>> addNotification({
    required String title,
    required String body,
    required String token,
    required String productId,
    required String imageUrl,
  });
}
