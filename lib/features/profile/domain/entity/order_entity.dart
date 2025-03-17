import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class OrderEntity {
  final String uId;
  final String orderId;
  final double totalAmount;
  final List<ProductEntity> items;
  final String status;
  final DateTime orderDate;

  OrderEntity(
      {required this.uId,
      required this.orderId,
      required this.totalAmount,
      required this.items,
      required this.status,
      required this.orderDate});
}
