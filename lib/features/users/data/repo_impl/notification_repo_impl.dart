import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/notification_service.dart';
import 'package:shop_sphere/features/users/domain/repo/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo {

  @override
  Future<Either<FirebaseFailure, String>> addNotification(
      {required String title, required String body, required String token})async {
   try {
    await NotificationService.sendNotification(title: title, body: body, token: token);
     return right("Notification sent successfully");
   }on FirebaseException catch (e) {
     return Left(FirebaseFailure.fromCode(e.code));
   }
   catch (e) {
     return Left(FirebaseFailure(message: e.toString()));
   }
  }
}
