import 'dart:typed_data';

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
    required Uint8List imageFile,
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
        emit(const DashboardSuccess());
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
        emit(const DashboardSuccess());
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
        emit(const DashboardSuccess());
      },
    );
  }
}
