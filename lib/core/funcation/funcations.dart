import 'package:flutter/material.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_new_address_body.dart';

class Funcations {
 static  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
static void addNewAddress(BuildContext context) {
      showModalBottomSheet(
      
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const CustomAddNewAddressBody();
        });
  }
}