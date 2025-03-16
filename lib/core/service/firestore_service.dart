// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';

class FirestoreService {
  FirebaseFirestore firestore;
  FirestoreService({
    required this.firestore,
  });
 Future <void> addData({ required String collection,required String did,required UserModel data})async {
   await firestore.collection(collection).doc(did).set(data.toMap());
  }
  
   
}
