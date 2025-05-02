part of 'mange_users_cubit.dart';

sealed class MangeUsersState extends Equatable {
  const MangeUsersState();

  @override
  List<Object> get props => [];
}

final class MangeUsersInitial extends MangeUsersState {}
final class MangeUsersLoading extends MangeUsersState {}
final class MangeUsersSuccess extends MangeUsersState {
  final List<UserEntity> users;
  const MangeUsersSuccess({required this.users});
}final class MangeStaffProductsSuccess extends MangeUsersState {
  final List<ProductEntity> products;
  const MangeStaffProductsSuccess({required this.products});
}

final class MangeUsersFailure extends MangeUsersState {
  final String errMessage;
  const MangeUsersFailure({required this.errMessage});
}
