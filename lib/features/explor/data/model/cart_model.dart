import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

class CartItemModel extends CartEntity {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  }) : super(productId: id, productImage: imageUrl, productName: name, productPrice: price, productQuantity: quantity);

  // Convert CartItem to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  // Convert a Firestore document to CartItem
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}


