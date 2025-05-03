class ProductEntity {
  final String pId;
  final String name;
  final String description;
  final double price;

  final String imageUrl;

  final String category;
  final int stock;

  final bool isFeatured;
  final String sId;
   final DateTime createdAt;
  final String staffName;
  ProductEntity({
    required this.staffName,
    required this.createdAt,
    required this.pId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    required this.isFeatured,
    required this.sId,
  });
}
