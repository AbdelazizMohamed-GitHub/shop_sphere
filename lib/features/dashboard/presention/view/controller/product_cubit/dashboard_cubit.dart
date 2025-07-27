import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.dashboardRepo}) : super(DashboardInitial());
  int currentIndex = 0;
  void changeScreenIndex(int index) {
    emit(DashboardState(screenIndex: index));
  }

  final DashboardRepo dashboardRepo;
  Future<void> addProduct({
    required ProductModel product,
    required File imageFile,
  }) async {
    emit(DashboardLoading());
    var result = await dashboardRepo.addProduct(
      product: product,
      imageFile: imageFile,
    );
    result.fold(
      (error) {
        emit(DashboardFailer(errMessage: error.message));
      },
      (r) async {
        emit(DashboardSuccess());
      },
    );
  }

  Future<void> deleteProduct({required String dId, required imageUrl}) async {
    emit(DashboardLoading());
    var result =
        await dashboardRepo.deleteProduct(dId: dId, imageUrl: imageUrl);
    result.fold(
      (error) {
        emit(DashboardFailer(errMessage: error.message));
      },
      (r) {
        emit(DashboardSuccess());
      },
    );
  }

  Future<void> updateProduct({
    required String dId,
    required ProductModel data,
  }) async {
    emit(DashboardLoading());
    var result = await dashboardRepo.updateProduct(data: data);
    result.fold(
      (error) {
        emit(DashboardFailer(errMessage: error.message));
      },
      (r) {
        emit(DashboardSuccess());
      },
    );
  }
}
