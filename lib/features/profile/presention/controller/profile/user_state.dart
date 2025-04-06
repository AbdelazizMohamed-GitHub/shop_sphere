import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class UserState {}

final class ProfileInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserEntity user;

  UserSuccess({required this.user});
}

final class UserFailure extends UserState {
  final String errMessage;

  UserFailure({required this.errMessage});
}

