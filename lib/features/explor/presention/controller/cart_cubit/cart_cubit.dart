import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/explor/domain/repo/cart_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  // ✅ Store subscription

  CartCubit({required this.cartRepo}) : super(CartInitial()) {
    listenIsProductInCart();
  }

  Future<void> addToCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.addToCart(productId: productId);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());
      listenIsProductInCart();
    });
  }

  void getAllProductsInCart() async {
    emit(CartLoading());
    final result = await cartRepo.getAllProductsInCart();
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (data) => emit(GetCartSuccess(products: data)),
    );
  }

  void listenIsProductInCart() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        emit(IsProductInCart(cartProduct: [])); // No favorites
        return;
      }

      List<String> favProducts =
          List<String>.from(snapshot.data()?['cartProduct'] ?? []);
      emit(IsProductInCart(cartProduct: favProducts));
    });
  }

  Future<void> removeFromCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.removeFromCart(productId: productId);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());

      listenIsProductInCart();
    }
        // ✅ Firestore listener updates UI automatically
        );
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    final result = await cartRepo.clearCart();
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (data) =>
          emit(CartSuccess()), // ✅ Firestore listener updates UI automatically
    );
  }
}
