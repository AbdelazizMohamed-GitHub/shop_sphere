// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepo}) : super(ProductInitial());
  final ProductRepo productRepo;

  Future<void> getProducts() async {
    emit(ProductLoading());
    

    final result = await productRepo.getProducts();
    result.fold((firebaseFailure) {
      emit(ProductFailure(errMessage: firebaseFailure.message));
    }, (products) {
      emit(ProductSuccess(products: products));
    });
  }
Future<void> addAndRemoveToFavorite(String productId)async {
    emit(ProductLoading());
    final result = await productRepo.addAndRemoveToFavorite(productId: productId);
    result.fold((firebaseFailure) {
      emit(ProductFailure(errMessage: firebaseFailure.message));
    }, (user) {
      emit(AddProductToFavoriteSuccess());
    });
  }
}
