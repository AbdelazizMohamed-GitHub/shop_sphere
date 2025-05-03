import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  @override
  final String id;
  final Timestamp createdAt;

  @override
  final String title;
  @override
  final String phoneNumber;

  @override
  final String street;
  @override
  final String city;
  @override
  final String state;
  @override
  final String country;
  @override
  final String postalCode;

  AddressModel({
    required this.createdAt,
    required this.id,
    required this.title,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  }) : super(
            street: street,
            city: city,
            state: state,
            country: country,
            postalCode: postalCode,
            title: title,
            phoneNumber: phoneNumber,
            id: id);

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'title': title,
      'id': id,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }

  // Convert from Map
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      createdAt: map['createdAt'] ?? Timestamp.now(),
      id: map['id'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      title: map['title'] ?? "",
      street: map['street'] ?? "",
      city: map['city'] ?? "",
      state: map['state'] ?? "",
      country: map['country'] ?? "",
      postalCode: map['postalCode'] ?? "",
    );
  }
}
