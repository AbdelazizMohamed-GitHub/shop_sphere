// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/explor/domain/repo/cart_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
    {required this.cartRepo,
  }
  ) : super(CartInitial());
  final CartRepo cartRepo;
  void addToCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.addToCart(productId: productId);
    result.fold(
      (failure) {
        emit(CartFailure(errMessage: failure.message));
      },
      (data) {
        emit(CartSuccess());
      },
    );
  }
  void getAllProductsInCart() async {
    emit(CartLoading());
    final result = await cartRepo.getAllProductsInCart();
    result.fold(
      (failure) {
        emit(CartFailure(errMessage: failure.message));
      },
      (data) {
        emit(GetCartSuccess(products: data));
      },
    );
  }
  void isProductInCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.isProductInCart(productId: productId);
    result.fold(
      (failure) {
        emit(CartFailure(errMessage: failure.message));
      },
      (data) {
        emit(IsProductInCart(isProductInCart: data));
      },
    );
  }
  void removeFromCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.removeFromCart(productId: productId);
    result.fold(
      (failure) {
        emit(CartFailure(errMessage: failure.message));
      },
      (data) {
        emit(CartSuccess());
      },
    );
  }
  void clearCart() async {
    emit(CartLoading());
    final result = await cartRepo.clearCart();
    result.fold(
      (failure) {
        emit(CartFailure(errMessage: failure.message));
      },
      (data) {
        emit(CartSuccess());
      },
    );
  }
  
}
