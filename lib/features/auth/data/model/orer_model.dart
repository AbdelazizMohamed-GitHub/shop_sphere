import 'package:shop_sphere/features/auth/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class OrderHistoryModel extends OrderEntity {
  @override
  final String orderId;
  @override
  final double totalAmount;
  @override
  final List<ProductEntity> items;
  @override
  final String status;
  @override
  final DateTime orderDate;

  OrderHistoryModel({
    required this.orderId,
    required this.totalAmount,
    required this.items,
    required this.status,
    required this.orderDate,
  }) : super(orderId: orderId, totalAmount: totalAmount, items: items, status:status , orderDate: orderDate);

  // Convert to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'totalAmount': totalAmount,
      'items': items,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  // Convert from Map
  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      orderId: map['orderId'],
      totalAmount: map['totalAmount'],
      items: List<ProductModel>.from(
          map['items']?.map((x) => ProductModel.fromMap(x)) ?? []),
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
    );
  }
}