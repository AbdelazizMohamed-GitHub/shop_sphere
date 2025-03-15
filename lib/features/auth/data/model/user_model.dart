import 'package:shop_sphere/features/auth/data/model/addres_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final int addressIndex;
  final List<AddressModel> address;
  final List<String> orderHistory;
  final List<String> wishlist;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.address,
    required this.orderHistory,
    required this.wishlist,
    required this.createdAt,
  });

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'address': address,
      'orderHistory': orderHistory,
      'wishlist': wishlist,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profileImage: map['profileImage'],
      address: map['address'],
      orderHistory: List<String>.from(map['orderHistory'] ?? []),
      wishlist: List<String>.from(map['wishlist'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
