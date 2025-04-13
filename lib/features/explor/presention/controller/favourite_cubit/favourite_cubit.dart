import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:shop_sphere/features/explor/domain/repo/favourite_repo.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.favouriteRepo}) : super(FavouriteInitial()) {
    listenToFavorites();
  }

  final FavouriteRepo favouriteRepo;
  StreamSubscription? _favListener;




  Future<void> addToFavorite({required String productId}) async {
    
    emit(FavouriteLoadingItem(
        productId: productId)); 

    final result = await favouriteRepo.addToFavorite(productId: productId);
    result.fold(
      (failure) {
       
        emit(FavouriteFailure(errMessage: failure.message));
      },
      (data) {
       
        emit(FavouriteSuccess());

        listenToFavorites();
      },
    );
  }

  void listenToFavorites() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _favListener?.cancel(); // Make sure to avoid multiple subscriptions
    _favListener = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        emit(IsFavourite(favProducts: const []));
        return;
      }

      List<String> favProducts =
          List<String>.from(snapshot.data()?['favProduct'] ?? []);
      emit(IsFavourite(favProducts: favProducts));
    });
  }

  @override
  Future<void> close() {
    _favListener?.cancel();
    return super.close();
  }
}

