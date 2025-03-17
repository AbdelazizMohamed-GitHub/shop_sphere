// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

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


  
   
}
