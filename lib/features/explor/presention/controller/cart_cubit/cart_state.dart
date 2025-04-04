import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

sealed class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {}

final class GetCartSuccess extends CartState {
  final List<CartEntity> cartItems;
  int total;
  GetCartSuccess({required this.cartItems,this.total = 0});
}


final class IsProductInCart extends CartState {
  final List<String> cartProduct;
  IsProductInCart({required this.cartProduct});
}

final class CartFailure extends CartState {
  final String errMessage;
  CartFailure({required this.errMessage});
}
