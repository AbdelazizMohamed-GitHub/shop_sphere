abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteUpdated extends FavouriteState {
  final List<String> favProducts;
  final Set<String> loadingItems;

  FavouriteUpdated({
    required this.favProducts,
    required this.loadingItems,
  });
}


class FavouriteFailure extends FavouriteState {
  final String errMessage;
  FavouriteFailure({required this.errMessage});
}

