
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserDataLoading extends ProfileState {}

final class GetUserDataSuccess extends ProfileState {
  final UserEntity user;

  GetUserDataSuccess({required this.user});
}

final class GetUserDataFailure extends ProfileState {
  final String errMessage;

  GetUserDataFailure( {required this.errMessage});

}
final class EditProfileLoading extends ProfileState{}

final class EditProfileSuccess extends ProfileState{}
final class EditProfileFailure extends ProfileState{
  final String errMessage;

  EditProfileFailure( {required this.errMessage});
}