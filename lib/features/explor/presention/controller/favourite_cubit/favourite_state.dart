
 import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
final class FavouriteLoading extends FavouriteState {}
final class FavouriteSuccess extends FavouriteState {}
final class GetFavouriteSuccess extends FavouriteState {
  final List<ProductEntity> products;
  GetFavouriteSuccess({required this.products});
}
final class IsFavourite extends FavouriteState {
  final bool isFavourite;
  IsFavourite({required this.isFavourite});
}

final class FavouriteFailure extends FavouriteState {
  final String errMessage;
  FavouriteFailure({required this.errMessage});
}
