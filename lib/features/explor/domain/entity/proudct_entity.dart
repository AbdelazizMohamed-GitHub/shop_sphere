class ProductEntity {
  final String pId;
  final String name;
  final String description;
  final double price;
  
  final String imageUrl;

  final String category;
  final int stock;
 
  final bool isFeatured;
  ProductEntity({
    required this.pId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  
    required this.category,
    required this.stock,
    required this.isFeatured,
  });
}
