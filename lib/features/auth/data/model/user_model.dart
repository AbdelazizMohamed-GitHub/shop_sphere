
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String uid;
  @override
  final String gender;
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
  final DateTime createdAt;

  UserModel( {required this.gender,
    required this.birthDate,
    required this.addressIndex,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.createdAt,
  
  }) : super(
            uid: uid,
            name: name,
            email: email,
            gender: gender,
            birthDate: birthDate,
            phoneNumber: phoneNumber,
            profileImage: profileImage,
            addressIndex: addressIndex,
            createdAt: createdAt);

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
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
     
      birthDate: DateTime.parse(map['birthDate']),
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      profileImage: map['profileImage'] ?? "",
      addressIndex: map['addressIndex'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']), gender: map['gender'] ?? "",
    );
  }
}
