import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserDataLoading extends ProfileState {}

final class GetUserDataSuccess extends ProfileState {
  final UserEntity user;

  GetUserDataSuccess({required this.user});
}

final class GetUserDataFirebaseFailure extends ProfileState {
  final String errMessage;

  GetUserDataFirebaseFailure({required this.errMessage});
}

final class EditProfileLoading extends ProfileState {}

final class EditProfileSuccess extends ProfileState {}

final class EditProfileFirebaseFailure extends ProfileState {
  final String errMessage;

  EditProfileFirebaseFailure({required this.errMessage});
}

final class AddAddressLoading extends ProfileState {}

final class AddAddressSuccess extends ProfileState {}

final class AddAddressFirebaseFailure extends ProfileState {
  final String errMessage;

  AddAddressFirebaseFailure({required this.errMessage});
}
