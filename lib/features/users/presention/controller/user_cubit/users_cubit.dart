import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/users/domain/repo/users_repo.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

part 'users_state.dart';

class MangeUsersCubit extends Cubit<MangeUsersState> {
  MangeUsersCubit({required this.mangeUsersRepo}) : super(MangeUsersInitial());
  final UsersRepo mangeUsersRepo;

  Future<void> getUsers({required bool isStaff}) async {
    emit(MangeUsersLoading());
    final result = await mangeUsersRepo.getUsers(isStaff: isStaff);
    result.fold((l) => emit(MangeUsersFailure( errMessage: l.message)),
        (users) => emit(MangeUsersSuccess(users: users)));
  }
  Future <void> getStaffProducts({required String staffId}) async {
    emit(MangeUsersLoading());
    final result = await mangeUsersRepo.getStaffProducts(staffId: staffId);
    result.fold((l) => emit(MangeUsersFailure( errMessage: l.message)),
        (products) => emit(MangeStaffProductsSuccess(products: products)));
  }
}
