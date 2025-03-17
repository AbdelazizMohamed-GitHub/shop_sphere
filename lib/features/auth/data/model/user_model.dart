import 'package:shop_sphere/features/auth/data/model/addres_model.dart';
import 'package:shop_sphere/features/auth/data/model/orer_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String uid;
  @override
  final String name;
  @override
  final String email;
  @override
  final DateTime birthDate;
  @override
  final String phoneNumber;
  @override
  final String profileImage;
  @override
  final int addressIndex;
  @override
  final List<AddressModel> address;
  @override
  final List<OrderHistoryModel> orderHistory;

  @override
  final DateTime createdAt;

  UserModel( {required this.birthDate,
    required this.addressIndex,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.address,
    required this.orderHistory,
    required this.createdAt,
  }) : super(uid: uid, name: name, email: email, birthDate: birthDate, phoneNumber: phoneNumber, profileImage: profileImage, addressIndex: addressIndex, address:address , orderHistory: orderHistory, createdAt: createdAt);

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'birthDate': birthDate.toIso8601String(),
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
      birthDate: DateTime.parse(map['birthDate']),
      uid: map['uid']??"",
      name: map['name']??"",
      email: map['email']??"",
      phoneNumber: map['phoneNumber']??"",
      profileImage: map['profileImage']??"",
      address: List<AddressModel>.from(
          map['address']?.map((x) => AddressModel.fromMap(x)) ?? []),
      addressIndex: map['addressIndex'],
      orderHistory: List<OrderHistoryModel>.from(
          map['orderHistory']?.map((x) => OrderHistoryModel.fromMap(x)) ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
