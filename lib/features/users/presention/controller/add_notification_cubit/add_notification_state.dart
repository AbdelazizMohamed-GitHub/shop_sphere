part of 'add_notification_cubit.dart';

sealed class AddNotificationState extends Equatable {
  const AddNotificationState();

  @override
  List<Object> get props => [];
}

final class AddNotificationInitial extends AddNotificationState {}
final class AddNotificationLoading extends AddNotificationState {}
final class AddNotificationSuccess extends AddNotificationState {}
final class AddNotificationFailure extends AddNotificationState {
  final String errMessage;
  const AddNotificationFailure({required this.errMessage});
}
