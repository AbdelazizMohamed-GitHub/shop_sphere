// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/explor/domain/repo/favourite_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.favouriteRepo}) : super(FavouriteInitial());
  final FavouriteRepo favouriteRepo;
  Future<void> addToFavorite({required String productId}) async {
    emit(FavouriteLoading());
    final result = await favouriteRepo.addToFavorite(productId: productId);
    result.fold(
      (failure) {
        emit(FavouriteFailure(errMessage: failure.message));
      },
      (data) async {
        emit(FavouriteSuccess());
        await isFavoriteExit(productId: productId);
      },
    );
  }

  Future<void> isFavoriteExit({required String productId}) async {
    emit(FavouriteLoading());
    final result = await favouriteRepo.isFavoriteExit(productId: productId);
    result.fold(
      (failure) {
        emit(FavouriteFailure(errMessage: failure.message));
      },
      (data) {
        emit(IsFavourite(isFavourite: data));
      },
    );
  }

 
  }

