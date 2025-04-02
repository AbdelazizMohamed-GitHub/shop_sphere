import 'package:shop_sphere/features/explor/data/model/product_model.dart';

class UserEntity {
  final String uid;
  final String name;
  final String email;
  final DateTime birthDate;
  final String phoneNumber;
  final String profileImage;
  final int addressIndex;
  final String gender;

  final DateTime createdAt;
  final List<String> favProduct;
  final List<String> cartProduct;

  const UserEntity( {required this.gender,required this.favProduct,
    required this.uid,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.phoneNumber,
    required this.profileImage,
    required this.addressIndex,
    required this.createdAt,
    required this.cartProduct,
  });
}
