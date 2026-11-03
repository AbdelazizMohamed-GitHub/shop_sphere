import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/users/domain/repo/notification_repo.dart';

part 'add_notification_state.dart';

class AddNotificationCubit extends Cubit<AddNotificationState> {
  AddNotificationCubit({
    required this.notificationRepo,
  }) : super(AddNotificationInitial());

  final NotificationRepo notificationRepo;

  Future<void> addNotification({
    required String title,
    required String body,
    required String token,
    required String productId,
    required String imageUrl,
  }) async {
    emit(AddNotificationLoading());

    try {
      final result = await notificationRepo.addNotification(
        title: title,
        body: body,
        token: token,
        productId: productId,
        imageUrl: imageUrl,
      );

      result.fold(
        (failure) {
          emit(AddNotificationFailure(
            errMessage: failure.message,
          ));
        },
        (_) {
          emit(AddNotificationSuccess());
        },
      );
    } catch (e) {
      emit(AddNotificationFailure(
        errMessage: e.toString(),
      ));
    }
  }
}
