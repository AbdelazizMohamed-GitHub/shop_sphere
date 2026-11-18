import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_sphere/core/service/supabase_service.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductService {

   FirebaseFirestore firestore;
  ProductService({
    required this.firestore,
  });

  Future<void> addProduct(
      {required ProductModel data, required Uint8List image}) async {
    String? imageUrl;

    imageUrl = await SupabaseService().uploadImage( fileBytes: image, fileExtension: 'jpg');
    data.imageUrl = imageUrl!;

    await firestore.collection('products').doc(data.pId).set(data.toMap());
  }

  Future<List<ProductEntity>> getProducts({required String category}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (category == "All") {
      snapshot = await firestore
          .collection('products')
          .orderBy("createdAt", descending: true)
          .get();
    } else {
      snapshot = await firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
    }

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> deleteProduct(
      {required String dId, required String imageUrl}) async {
    await SupabaseService().deleteImageFromUrl(imageUrl: imageUrl);
    await firestore.collection('products').doc(dId).delete();
  }

  Future<void> updateProduct(
      {required String dId, required ProductModel data}) async {
   
    await firestore.collection('products').doc(dId).update(data.toMap());
  }
    Future<ProductEntity> getProductById({required String productId}) async {
  ProductEntity data=await  FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get()
        .then((value) {
      if (value.exists) {
        return ProductModel.fromMap(value.data()!);
      } else {
        throw Exception("Product not found");
      }
    }).catchError((error) {
      throw Exception("Error fetching product: $error");
    });
  return data;
  }
  Future<void> toggelProductToFavorite({required String productId}) async {
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

      if (userModel.favProduct.isEmpty) {
        return []; // No favorites, return empty list
      }

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
   


}