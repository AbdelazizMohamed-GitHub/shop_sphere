import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class OrderEntity {
  final String uId;
  final String orderId;
  final String userName;
  final double totalAmount;
  final List<CartItemModel> items;
  final String status;
  final DateTime orderDate;
  final AddressEntity address;

  OrderEntity(
      {required this.uId,
      required this.userName,
      required this.address,
      required this.orderId,
      required this.totalAmount,
      required this.items,
      required this.status,
      required this.orderDate});
}
