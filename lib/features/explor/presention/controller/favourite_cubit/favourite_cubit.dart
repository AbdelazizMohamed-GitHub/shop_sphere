
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';



class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  Future<void> addAndRemoveToFavorite(String productId)async {
    emit(FavoriteLoading());
    final result = await productRepo.addAndRemoveToFavorite(productId: productId);
    result.fold((firebaseFailure) {
      emit(ProductFailure(errMessage: firebaseFailure.message));
    }, (user) {
      emit(FavoriteSuccess());
    });
  }
}
