import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
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
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("products")
        .orderBy("createdAt", descending: true)
        .get();
    return querySnapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }
}
