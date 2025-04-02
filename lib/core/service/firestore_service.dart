import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class FirestoreService {
  FirebaseFirestore firestore;
  FirestoreService({
    required this.firestore,
  });
  Future<void> addData(
      {required String collection,
      required String did,
      required UserModel data}) async {
    await firestore.collection(collection).doc(did).set(data.toMap());
  }

  Future<void> updateData(
      {required String collection,
      required String did,
      required UserModel data}) async {
    await firestore.collection(collection).doc(did).update(data.toMap());
  }

  Future<UserEntity> getUserData({
    required String collection,
    required String did,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection(collection).doc(did).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("Document not found in collection: $collection");
    }

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> addAddress(
      {required String addressId, required AddressModel adress}) async {
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .set(adress.toMap());
  }

  Future<void> updateAddress(
      {required String addressId, required AddressModel adress}) async {
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .update(adress.toMap());
  }

  Future<void> deleteAddress({required String addressId}) async {
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .delete();
  }

  Future<List<AddressEntity>> getAddress() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .orderBy("createdAt", descending: true)
        .get();
    return querySnapshot.docs
        .map((e) => AddressModel.fromMap(e.data()))
        .toList();
  }

  Future<List<ProductEntity>> getProduct() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("products").get();
    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> addToFavorite({required String productId}) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = firestore.collection("users").doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) return; // Handle if user document doesn't exist

    UserModel userModel =
        UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

    // Toggle favorite status
    if (userModel.favProduct.contains(productId)) {
      userModel.favProduct.remove(productId);
    } else {
      userModel.favProduct.add(productId);
    }

    // Update Firestore with modified favorites
    await userRef.update({"favProduct": userModel.favProduct});
  }

  Future<List<String>> isFavoriteExist({required String productId}) async {
    List<String> favProducts = [];
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return;
      }

      favProducts = List<String>.from(snapshot.data()?['favProduct'] ?? []);
    });
    return favProducts;
  }

  Stream<List<ProductEntity>> getAllFavoriteProducts() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return const Stream.empty();

    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (!snapshot.exists || snapshot.data() == null) return [];

      UserModel userModel =
          UserModel.fromMap(snapshot.data() as Map<String, dynamic>);

      if (userModel.favProduct.isEmpty)
        return []; // No favorites, return empty list

      // Fetch all favorite products in a single Firestore query
      List<ProductEntity> products = [];
      var productDocs = await firestore
          .collection("products")
          .where('id', whereIn: userModel.favProduct)
          .get();

      for (var doc in productDocs.docs) {
        products.add(ProductModel.fromMap(doc.data()));
      }

      return products;
    });
  }

  Future<void> addToCart({required CartItemModel cartItemModel,}) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(cartItemModel.id);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) return; // Handle if user document doesn't exist

    // Toggle cart status
    if (userDoc.exists) {
     await userRef.delete();
    } else {
      await userRef.set(cartItemModel.toMap());
    }

    // Update Firestore with modified cart
  }

    Future<List<ProductEntity>> getAllProductsInCart() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return []; // Ensure user is logged in

    DocumentSnapshot userDoc =
        await firestore.collection("users").doc(userId).get();

    if (!userDoc.exists || userDoc.data() == null) return [];

    UserModel userModel =
        UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

    if (userModel.cartProduct.isEmpty) return []; // No products in cart

    // Fetch all products in cart
    List<ProductEntity> products = [];
    var productDocs = await firestore
        .collection("products").doc(userId).collection("cart")
        .where('id', whereIn: userModel.cartProduct)
        .get();

    for (var doc in productDocs.docs) {
      products.add(ProductModel.fromMap(doc.data()));
    }

    return products;
  }

  Future<void> clearCart() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

await firestore.collection("users").doc(userId).collection("cart").get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    
  }
}
