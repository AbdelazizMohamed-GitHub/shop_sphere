class AddressEntity {
  final String id;
    final String title;
final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  AddressEntity({
    required this.id,
    required this.phoneNumber,
    required this.title,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });
}
