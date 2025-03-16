import 'package:shop_sphere/features/auth/data/model/addres_model.dart';
import 'package:shop_sphere/features/auth/data/model/orer_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final int addressIndex;
  final List<AddressModel> address;
  final List<OrderHistoryModel> orderHistory;
  
  final DateTime createdAt;

  UserModel( {required this.addressIndex,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.address,
    required this.orderHistory,
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
      'addressIndex': addressIndex,
      'address': address.map((e) => e.toMap()).toList(),
      'orderHistory': orderHistory.map((e) => e.toMap()).toList(),
    
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
      address: List<AddressModel>.from(
          map['address']?.map((x) => AddressModel.fromMap(x)) ?? []),
      addressIndex: map['addressIndex'],
      orderHistory: List<OrderHistoryModel>.from(
          map['orderHistory']?.map((x) => OrderHistoryModel.fromMap(x)) ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
