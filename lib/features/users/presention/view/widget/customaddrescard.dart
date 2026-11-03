import 'package:flutter/material.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class CustomAddressCard extends StatelessWidget {
  const CustomAddressCard({super.key, required this.address});

  final AddressEntity address;

  @override
  Widget build(BuildContext context) {
    final location = [
      address.street,
      address.city,
      address.state,
      address.country,
      address.postalCode,
    ].where((part) => part.trim().isNotEmpty).join(', ');

    return Card(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(
          Icons.location_on_outlined,
          size: 30,
        ),
        title: Text(address.title.isEmpty ? 'Address' : address.title,
            style: AppStyles.text16Bold),
        subtitle: Text([
          if (location.isNotEmpty) location,
          if (address.phoneNumber.isNotEmpty) address.phoneNumber,
        ].join('\n')),
      ),
    );
  }
}
