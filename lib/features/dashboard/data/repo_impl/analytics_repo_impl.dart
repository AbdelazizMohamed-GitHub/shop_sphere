import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/analytics_repo.dart';

class AnalyticsRepoImpl extends AnalyticsRepo {
  FirestoreService firestoreService;
  AnalyticsRepoImpl({required this.firestoreService});
  @override
  Future<Either<FirebaseFailure, List<int>>> getDayOrdersTotalPrice() async{
try {
 List<int> days= await firestoreService.getDaysTotal();

  return Right(days);
} on FirebaseException catch (e) {
  return Left(FirebaseFailure.fromCode(e.code));
}on Exception catch (e) {
  return Left(FirebaseFailure(message: e.toString()));
}
  }

  @override
  Future<Either<FirebaseFailure, double>> getOrdersTotalPriceTimeRange(
      {required int timeRangeIndex})async {
    try {
      double data=await firestoreService.getOrdersTotalPriceTimeRange(timeRangeIndex: timeRangeIndex);
      return Right(data);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromCode(e.code));
    }on Exception catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}
