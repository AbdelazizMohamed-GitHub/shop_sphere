// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  FirebaseFirestore firestore;
  FirestoreService({
    required this.firestore,
  });
 Future <void> addData({ required String collection,required String did,required UserModel data})async {
   await firestore.collection(collection).doc(did).set(data.toMap());
  }
  Future <void> updateData({ required String collection,required String did,required UserModel data})async {
   await firestore.collection(collection).doc(did).update(data.toMap());

  }
  Future<UserEntity> getData({
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
Future <void> addAddress(AddressModel adress)async {
  String addressId =const Uuid().v4();
await firestore.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).collection("address").doc( addressId).set(adress.toMap()  );
}


  
   
}
