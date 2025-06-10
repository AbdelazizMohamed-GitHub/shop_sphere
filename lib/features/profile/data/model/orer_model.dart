import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  @override
  final String orderId;
  @override
  final String userName;
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
  @override
  final String paymentMethod;
  @override
  final int delivaryCoast; // Default value, can be modified later
  @override
  final int trackingNumber;
  OrderModel({
    required this.uId,
    required this.address,
    required this.userName,
    required this.orderId,
    required this.totalAmount,
    required this.items,
    required this.status,
    required this.orderDate,
    required this.paymentMethod,
    required this.delivaryCoast,
    required this.trackingNumber,
  }) : super(
            uId: uId,
            userName: userName,
            orderId: orderId,
            totalAmount: totalAmount,
            items: items,
            status: status,
            orderDate: orderDate,
            address: address,
            paymentMethod: paymentMethod,
            delivaryCoast: delivaryCoast,
            trackingNumber: trackingNumber);
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      uId: entity.uId,
      userName: entity.userName,
      orderId: entity.orderId,
      totalAmount: entity.totalAmount,
      items: entity.items,
      status: entity.status,
      orderDate: entity.orderDate,
      address: entity.address as AddressModel,
      paymentMethod: entity.paymentMethod,
      delivaryCoast: entity.delivaryCoast,
      trackingNumber: entity.trackingNumber, // Assuming trackingNumber is part of OrderEntity
    );
  }

  // Convert from Map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userName: map['userName'] ?? '',
      address: AddressModel.fromMap(map['address']),
      uId: map['uId'],
      orderId: map['orderId'],
      totalAmount: map['totalAmount'],
      items: List<CartItemModel>.from(
          map['items']?.map((x) => CartItemModel.fromMap(x)) ?? []),
      status: map['status'],
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      paymentMethod: map['paymentMethod'] ?? 'Cash on Delivery',
      delivaryCoast: map['delivaryCoast'] ?? 0, // Default value if not provided
      trackingNumber: map['trackingNumber'] ?? 0, // Default value if not provided
    );
  }
  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'orderId': orderId,
      'totalAmount': totalAmount,
      'items': items.map((x) => x.toMap()).toList(),
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'address': address.toMap(),
      'paymentMethod': paymentMethod,
      'delivaryCoast': delivaryCoast,
      'trackingNumber': trackingNumber, // Assuming trackingNumber is part of OrderEntity
    };
  }
}
