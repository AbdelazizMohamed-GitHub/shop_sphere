
 import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class FavouriteState extends Equatable {
  @override
  
  List<Object?> get props => [];
}

final class FavouriteInitial extends FavouriteState {}
final class FavouriteLoadingItem extends FavouriteState {
    final String productId;
  FavouriteLoadingItem({required this.productId});

  @override
  List<Object?> get props => [productId];
}
final class FavouriteSuccess extends FavouriteState {}
final class GetFavouriteSuccess extends FavouriteState {
  final List<ProductEntity> products;
  GetFavouriteSuccess({required this.products});
}
final class IsFavourite extends FavouriteState {
  final List<String> favProducts;
  IsFavourite({required this.favProducts});
}

final class FavouriteFailure extends FavouriteState {
  final String errMessage;
  FavouriteFailure({required this.errMessage});
}
