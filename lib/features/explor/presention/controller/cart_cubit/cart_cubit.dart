import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/domain/repo/cart_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  StreamSubscription? _cartListener;

  CartEntity? cartEntity;

  Future<void> addToCart({required CartItemModel cartItemModel}) async {
    emit(CartLoading());
    final result = await cartRepo.addToCart(cartItemModel: cartItemModel);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());
      listenIsProductInCart();
    });
  }

  void getAllProductsInCart() async {
    int total = 0;
    emit(CartLoading());
    final result = await cartRepo.getAllProductsInCart();
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (data) {
        for (var cartItem in data) {
          total += (cartItem.productPrice * cartItem.productQuantity).toInt();
        }
        emit(GetCartSuccess(cartItems: data, total: total));
      },
    );
  }

  void listenIsProductInCart() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _cartListener = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .snapshots()
        .listen((snapshot) {
      List<String> cartProductIds = snapshot.docs.map((doc) => doc.id).toList();
      emit(IsProductInCart(cartProduct: cartProductIds));
    });
  }

  Future<void> removeFromCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.removeFromCart(productId: productId);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());

      listenIsProductInCart();
    });
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

  Future<void> updateCartQuantity(
      {required String productId, required bool isIncrement}) async {
    emit(CartLoading());
    final result = await cartRepo.updateCartQuantity(
        productId: productId, isIncrement: isIncrement);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());
    });
  }

  Future<void> updateCartQuantityWithCount(
      {required String productId, required int count}) async {
    emit(CartLoading());
    final result = await cartRepo.updateCartQuantityWithCount(
        productId: productId, count: count);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) {
      emit(CartSuccess());
    });
  }

  Future<void> getProductInCart({required String productId}) async {
    emit(CartLoading());

    final result = await cartRepo.getProductInCart(productId: productId);
    result.fold((failure) => emit(CartFailure(errMessage: failure.message)),
        (data) async {
      cartEntity = data;
     

      Future.delayed(const Duration(seconds: 3), () {
        listenIsProductInCart();
      });
    });
  }

  @override
  Future<void> close() {
    _cartListener?.cancel();
    return super.close();
  }
}
