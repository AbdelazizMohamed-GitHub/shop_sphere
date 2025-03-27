// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/explor/domain/repo/product_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepo}) : super(ProductInitial());
  final ProductRepo productRepo;

  Future<void> getProducts() async {
    emit(ProductLoading());
    await Future.delayed(const Duration(seconds: 6));

    final result = await productRepo.getProducts();
    result.fold((firebaseFailure) {
      emit(ProductFirebaseFailure(errMessage: firebaseFailure.message));
    }, (products) {
      emit(ProductSuccess(products: products));
    });
  }
}
