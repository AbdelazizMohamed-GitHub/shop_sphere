import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {}

final class GetCartSuccess extends CartState {
  final List<CartEntity> cartItems;
  final int total;
  GetCartSuccess({required this.cartItems, this.total = 0});
}

final class CartFailure extends CartState {
  final String errMessage;
  CartFailure({required this.errMessage});
}

class CartUpdated extends CartState {
  final List<String> cartProduct;
  final Set<String> loadingItems;
  CartUpdated({required this.cartProduct, required this.loadingItems});
}
