import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class OrderEntity {
  final String uId;
  final String orderId;
  final double totalAmount;
  final List<CartEntity> items;
  final String status;
  final DateTime orderDate;
   final AddressEntity address;

  OrderEntity(
      {required this.uId,required this.address,
      required this.orderId,
      required this.totalAmount,
      required this.items,
      required this.status,
      required this.orderDate});
}
