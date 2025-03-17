
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserDataLoading extends ProfileState {}

final class GetUserDataSucess extends ProfileState {
  final UserEntity user;

  GetUserDataSucess({required this.user});
}

final class GetUserDataFailure extends ProfileState {
  final String errMessage;

  GetUserDataFailure( {required this.errMessage});
}