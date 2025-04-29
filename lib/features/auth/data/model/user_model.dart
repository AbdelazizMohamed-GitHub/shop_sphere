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
  @override
  final List<String> favProduct;
  @override
  final bool isStaff;
  @override
  final String fcmToken;

  UserModel({
    required this.fcmToken,
    required this.favProduct,
    required this.gender,
    required this.birthDate,
    required this.addressIndex,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.createdAt,
    required this.isStaff,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          gender: gender,
          birthDate: birthDate,
          phoneNumber: phoneNumber,
          profileImage: profileImage,
          addressIndex: addressIndex,
          createdAt: createdAt,
          favProduct: favProduct,
          isStaff: isStaff,
          fcmToken: fcmToken,
        );

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
      'favProduct': favProduct,
      'gender': gender,
      'isStaff': isStaff,
      'fcmToken': fcmToken
    };
  }

  // Convert from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      isStaff: map['isStaff'] ?? false,
      birthDate: DateTime.parse(map['birthDate']),
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      profileImage: map['profileImage'] ?? "",
      addressIndex: map['addressIndex'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      gender: map['gender'] ?? "",
      favProduct: List<String>.from(map['favProduct'] ?? []),
      fcmToken: map['fcmToken'] ?? "",
    );
  }
  UserModel copyWith({
    String? uid,
    String? gender,
    String? name,
    String? email,
    DateTime? birthDate,
    String? phoneNumber,
    String? profileImage,
    int? addressIndex,
    DateTime? createdAt,
    List<String>? favProduct,
    bool? isStaff,
    String? fcmToken,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      addressIndex: addressIndex ?? this.addressIndex,
      createdAt: createdAt ?? this.createdAt,
      favProduct: favProduct ?? this.favProduct,
      isStaff: isStaff ?? this.isStaff,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
