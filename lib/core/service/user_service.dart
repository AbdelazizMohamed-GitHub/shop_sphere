import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class UserService {
  final FirebaseFirestore firestore;
  UserService({required this.firestore});
  
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

  Future<UserEntity> getUserData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User is not logged in"); // Ensure user is logged in
    }
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection('users').doc(userId).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("Document not found in collection: users");
    }

    return UserModel.fromMap(doc.data()!);
  }
  Future<void> changeUserRule(
      {required String userId, required bool isStaff}) async {
    await firestore
        .collection('users')
        .doc(userId)
        .update({"isStaff": isStaff});
  } 
  Future<List<UserEntity>> getUsers({required bool isStaff}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .where("isStaff", isEqualTo: isStaff)
        .get();

    return querySnapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
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

  Future<void> updateAddressIndex({required int sellectAddressIndex}) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = firestore.collection("users").doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) return; // Handle if user document doesn't exist

    // Update the address index
    await userRef.update({"addressIndex": sellectAddressIndex});
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

  Future<List<AddressEntity>> getCustomerAddresses(
      {required String userId}) async {
    final querySnapshot = await firestore
        .collection("users")
        .doc(userId)
        .collection("address")
        .orderBy("createdAt", descending: true)
        .get();
    return querySnapshot.docs
        .map((document) => AddressModel.fromMap(document.data()))
        .toList();
  }
  Future<List<ProductEntity>> getStaffProducts(
      {required String staffId}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("products")
        .where(
          "sId",
          isEqualTo: staffId,
        )
        .get();
    return querySnapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

}
