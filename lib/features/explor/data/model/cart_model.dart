import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';

class CartItemModel extends CartEntity {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final Timestamp? createdAt;

  CartItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
     this.createdAt,
  }) : super(
            productId: id,
            productImage: imageUrl,
            productName: name,
            productPrice: price,
            productQuantity: quantity);

  // Convert CartItem to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'createdAt': Timestamp.now(), // Default quantity to 1 if not provided
    };
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  // Convert a Firestore document to CartItem
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 1,
      createdAt: map['createdAt']?? Timestamp.now(), // Default quantity to 1 if not provided
    );
  }
   

  
}
