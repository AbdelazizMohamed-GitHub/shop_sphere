import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductModel extends ProductEntity {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final String imageUrl;
  @override
  final List imagesUrl;
  @override
  final String category;
  @override
  final int stock;
  final double rating;
  final int reviewsCount;
  @override
  final bool isFeatured;

  ProductModel(this.imagesUrl, {
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    required this.rating,
    required this.reviewsCount,
   required this.isFeatured,
  }) : super(
            id: id,
            name: name,
            description: description,
            price: price,
            imageUrl: imageUrl,
            imagesUrl: [],
            category: category,
            stock: stock,
            isFeatured: isFeatured);

  // Convert to Map (for Firebase, Hive, etc.)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'imagesUrl': imagesUrl,
      'category': category,
      'stock': stock,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isFeatured': isFeatured,
    };
  }

  // Create ProductModel from Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      map['imagesUrl'] ?? [],
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      isFeatured: map['isFeatured'] ?? false,
    );
  }
}
