import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';

class OrderModel extends OrderEntity {
  @override
  final String orderId;
  @override
  final String uId;
  @override
  final double totalAmount;
  @override
  final List<CartItemModel> items;
  @override
  final String status;
  
  @override
  final DateTime orderDate;
  @override
  final AddressModel address;

  OrderModel( {required this.uId,required this.address,
    required this.orderId,
    required this.totalAmount,
    required this.items,
    required this.status,
    required this.orderDate,
  }) : super( uId: uId, orderId: orderId, totalAmount: totalAmount, items: items, status:status , orderDate: orderDate, address: address);

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'orderId': orderId,
      'totalAmount': totalAmount,
      'items': List<CartItemModel>.from(
          items.map((x) => x.toMap())).toList(),
      'status': status,
      'orderDate': orderDate,
      'address': address.toMap(),
    };
  }

  // Convert from Map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      address: AddressModel.fromMap(map['address']),
      uId: map['uId'],
      orderId: map['orderId'],
      totalAmount: map['totalAmount'],
      items: List<CartItemModel>.from(
          map['items']?.map((x) => CartItemModel.fromMap(x)) ?? []),
      status: map['status'],
      orderDate: (map['orderDate']  as Timestamp).toDate(),
    );
  }
}