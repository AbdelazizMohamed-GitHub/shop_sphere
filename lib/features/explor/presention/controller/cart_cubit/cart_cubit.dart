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
  final Set<String> _loadingItems = {};
  List<String>? _latestCartProducts;
  CartEntity? cartEntity;

  void listenIsProductInCart() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _cartListener?.cancel();
    _cartListener = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .snapshots()
        .listen((snapshot) {
      _latestCartProducts = snapshot.docs.map((doc) => doc.id).toList();
      _emitUpdatedCartState();
    });
  }

  Future<void> addToCart({required CartItemModel cartItemModel}) async {
    _loadingItems.add(cartItemModel.id);
    _emitUpdatedCartState();

    final result = await cartRepo.addToCart(cartItemModel: cartItemModel);
    result.fold(
      (failure) {
        _loadingItems.remove(cartItemModel.id);
        emit(CartFailure(errMessage: failure.message));
        _emitUpdatedCartState();
      },
      (_) {
        _loadingItems.remove(cartItemModel.id);
        listenIsProductInCart(); // triggers state emit via snapshot
      },
    );
  }

  Future<void> removeFromCart({required String productId}) async {
    _loadingItems.add(productId);
    _emitUpdatedCartState();

    final result = await cartRepo.removeFromCart(productId: productId);
    result.fold(
      (failure) {
        _loadingItems.remove(productId);
        emit(CartFailure(errMessage: failure.message));
        _emitUpdatedCartState();
      },
      (_) {
        _loadingItems.remove(productId);
        listenIsProductInCart();
      },
    );
  }

  void _emitUpdatedCartState() {
    if (_latestCartProducts != null) {
      emit(IsProductInCart(
        cartProduct: _latestCartProducts!,
        loadingItems: _loadingItems,
      ));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    final result = await cartRepo.clearCart();
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (_) => emit(CartSuccess()), // Firestore listener will update cart
    );
  }

  Future<void> updateCartQuantity({
    required String productId,
    required bool isIncrement,
  }) async {
    emit(CartLoading());
    final result = await cartRepo.updateCartQuantity(
        productId: productId, isIncrement: isIncrement);
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (_) => emit(CartSuccess()),
    );
  }

  Future<void> updateCartQuantityWithCount({
    required String productId,
    required int count,
  }) async {
    emit(CartLoading());
    final result = await cartRepo.updateCartQuantityWithCount(
      productId: productId,
      count: count,
    );
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (_) => listenIsProductInCart(),
    );
  }

  Future<void> getProductInCart({required String productId}) async {
    emit(CartLoading());
    final result = await cartRepo.getProductInCart(productId: productId);
    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.message)),
      (data) {
        cartEntity = data;
        listenIsProductInCart();
      },
    );
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

  @override
  Future<void> close() {
    _cartListener?.cancel();
    return super.close();
  }
}
