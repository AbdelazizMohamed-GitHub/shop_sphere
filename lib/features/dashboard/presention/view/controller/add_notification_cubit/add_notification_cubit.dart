import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/notification_repo.dart';

part 'add_notification_state.dart';

class AddNotificationCubit extends Cubit<AddNotificationState> {
  AddNotificationCubit({required this.notificationRepo}) : super(AddNotificationInitial());
  final NotificationRepo notificationRepo;

  Future<void> addNotification({required String title, required String body, required String token}) async {
    emit(AddNotificationLoading());
    final result = await notificationRepo.addNotification(title: title, body: body, token: token);
    result.fold((l) => emit(AddNotificationFailure(errMessage: l.message)), (r) => emit(AddNotificationSuccess()));
  }
}
