import 'package:shop_sphere/features/explor/data/model/product_model.dart';

class OrderHistoryModel {
  final String orderId;
  final double totalAmount;
  final List<ProductModel> items;
  final String status;
  final DateTime orderDate;

  OrderHistoryModel({
    required this.orderId,
    required this.totalAmount,
    required this.items,
    required this.status,
    required this.orderDate,
  });

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