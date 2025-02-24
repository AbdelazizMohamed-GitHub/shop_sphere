class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  
  final String imageUrl;
  final List imagesUrl;
  final String category;
  final int stock;
 
  final bool isFeatured;
  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.imagesUrl,
    required this.category,
    required this.stock,
    required this.isFeatured,
  });
}
