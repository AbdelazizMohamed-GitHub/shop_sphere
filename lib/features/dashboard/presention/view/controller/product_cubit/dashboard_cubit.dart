import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.dashboardRepo}) : super(DashboardInitial()) {
    getProducts(category: 'All');
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
        await getProducts(category: 'All');
      },
    );
  }

  Future<void> getProducts({required String category}) async {
    emit(DashboardLoading());
    var result = await dashboardRepo.getProducts(category: category);
    result.fold(
      (error) {
        emit(DashboardFailer(errMessage: error.message));
      },
      (products) {
        emit(DashboardSuccess(products: products));
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
      (r) async {
        await getProducts(category: 'All');
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
      (r) async {
        await getProducts(category: 'All');
      },
    );
  }
}
