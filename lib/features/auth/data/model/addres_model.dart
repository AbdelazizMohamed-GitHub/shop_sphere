class AddressModel {
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
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
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      postalCode: map['postalCode'],
    );
  }
}
