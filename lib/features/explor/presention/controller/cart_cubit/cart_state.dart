
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartSuccess extends CartState {}
final class GetCartSuccess extends CartState {
  final List<ProductEntity> products;
  GetCartSuccess({required this.products});
}
final class IsProductInCart extends CartState {
  final bool isProductInCart;
  IsProductInCart({required this.isProductInCart});
}
final class CartFailure extends CartState {
  final String errMessage;
  CartFailure({required this.errMessage});
}

