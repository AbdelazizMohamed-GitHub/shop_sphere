import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductModel extends ProductEntity {
  @override
  final String pId;
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

  ProductModel( {required this.imageUrl,
    required this.pId,
    required this.sId,
    required this.name,
    required this.description,
    required this.price,

   
    required this.category,
    required this.stock,
  
   required this.isFeatured,

  }) : super(
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
     
      'isFeatured': isFeatured,
      'sId': sId,

    };
  }

  // Create ProductModel from Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
    
      pId: map['id'] ?? '',
      sId: map['sId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
    
      isFeatured: map['isFeatured'] ?? false,
    );
  }
}
