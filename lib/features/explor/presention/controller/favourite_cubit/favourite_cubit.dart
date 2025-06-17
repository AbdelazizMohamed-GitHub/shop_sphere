import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/features/explor/domain/repo/favourite_repo.dart';
import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.favouriteRepo}) : super(FavouriteInitial()) {
    _listenToFavorites();
  }

  final FavouriteRepo favouriteRepo;
  StreamSubscription? _favListener;
  List<String> _favProducts = [];
  final Set<String> _loadingItems = {};

  void _emitUpdated() {
    emit(FavouriteUpdated(
      favProducts: List.from(_favProducts),
      loadingItems: Set.from(_loadingItems),
    ));
  }

  void _listenToFavorites() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _favListener?.cancel();
    _favListener = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        _favProducts = [];
      } else {
        _favProducts = List<String>.from(snapshot.data()?['favProduct'] ?? []);
      }
      _emitUpdated();
    });
  }

  Future<void> toggleFavourite({required String productId}) async {
    if (!await AppFuncations.isOnline()) {
      
      return emit(FavouriteFailure(errMessage: "No Internet Connection"));
    }

    _loadingItems.add(productId);
    _emitUpdated();

    final result = await favouriteRepo.addToFavorite(productId: productId);

    result.fold(
      (failure) {
        _loadingItems.remove(productId);
        emit(FavouriteFailure(errMessage: failure.message));
        _emitUpdated();
      },
      (_) async {
        _loadingItems.remove(productId);
        _emitUpdated();
      },
    );
  }

  @override
  Future<void> close() {
    _favListener?.cancel();
    return super.close();
  }
}
