import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/repo/cart_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  // ✅ Store subscription

  CartCubit({required this.cartRepo}) : super(CartInitial()) ;

  Future<void> addToCart({required CartItemModel cartItemModel}) async {
    emit(CartLoading());
    final result = await cartRepo.addToCart(cartItemModel: cartItemModel);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());
      listenIsProductInCart(
      
      );
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
      .collection("cart")
      .snapshots()
      .listen((snapshot) {
    List<String> cartProductIds = snapshot.docs.map((doc) => doc.id).toList();
    emit(IsProductInCart(cartProduct: cartProductIds));
  });
}



  Future<void> removeFromCart({required CartItemModel cartItemModel}) async {
    emit(CartLoading());
    final result = await cartRepo.removeFromCart(cartItemModel: cartItemModel);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());

      listenIsProductInCart( 
      
      );
    }
      
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
