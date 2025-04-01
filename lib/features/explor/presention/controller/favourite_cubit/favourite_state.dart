
 class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
final class FavoriteLoading extends FavouriteState {}
final class FavoriteSuccess extends FavouriteState {}
final class FavoriteFailure extends FavouriteState {
  final String errMessage;
  FavoriteFailure({required this.errMessage});
}
