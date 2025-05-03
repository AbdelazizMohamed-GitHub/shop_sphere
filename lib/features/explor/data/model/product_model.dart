import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductModel extends ProductEntity {
  @override
  final String pId;
  @override
  final String sId;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  String imageUrl;

  @override
  final String category;
  @override
  final int stock;

  @override
  final bool isFeatured;
  final DateTime createdAt;
  final String staffName;

  ProductModel({
  required this.staffName,
    required this.imageUrl,
    required this.createdAt,
    required this.pId,
    required this.sId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.isFeatured,
  }) : super(
            staffName: staffName, 
            sId: sId,
            createdAt: createdAt,
            pId: pId,
            name: name,
            description: description,
            price: price,
            imageUrl: imageUrl,
            category: category,
            stock: stock,
            isFeatured: isFeatured);

  // Convert to Map (for Firebase, Hive, etc.)
  Map<String, dynamic> toMap() {
    return {
      'id': pId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'stock': stock,
      'createdAt': createdAt,
      'isFeatured': isFeatured,
      'sId': sId,
      'staffName': staffName,
    };
  }

  // Create ProductModel from Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      pId: map['id'] ?? '',
      sId: map['sId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
      isFeatured: map['isFeatured'] ?? false,
      staffName: map['staffName'] ?? '',
    );
  } ProductModel copyWith({
    String? pId,
    String? sId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    int? stock,
    bool? isFeatured,
    DateTime? createdAt,
    String? staffName,
  }) {
    return ProductModel(
      pId: pId ?? this.pId,
      sId: sId ?? this.sId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      staffName: staffName ?? this.staffName,
    );
  }
}
