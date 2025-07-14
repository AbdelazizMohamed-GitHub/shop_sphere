// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductMostSellerModel {
  final String productName;
  final int productCount;
  final double productPrice;
  final String productImageUrl;

  ProductMostSellerModel({
    required this.productName,
    required this.productCount,
    required this.productPrice,
    required this.productImageUrl,
  });

  ProductMostSellerModel copyWith({
    String? productName,
    int? productCount,
    double? productPrice,
    String? productImageUrl,
  }) {
    return ProductMostSellerModel(
      productName: productName ?? this.productName,
      productCount: productCount ?? this.productCount,
      productPrice: productPrice ?? this.productPrice,
      productImageUrl: productImageUrl ?? this.productImageUrl,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'productName': productName,
  //     'productCount': productCount,
  //     'productPrice': productPrice,
  //     'productImageUrl': productImageUrl,
  //   };
  // }

  // factory ProductMostSellerModel.fromMap(Map<String, dynamic> map) {
  //   return ProductMostSellerModel(
  //     productName: map['productName'] as String,
  //     productCount: map['productCount'] as int,
  //     productPrice: map['productPrice'] as double,
  //     productImageUrl: map['productImageUrl'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProductMostSellerModel.fromJson(String source) => ProductMostSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductMostSellerModel(productName: $productName, productCount: $productCount, productPrice: $productPrice, productImageUrl: $productImageUrl)';
  }

  // @override
  // bool operator ==(covariant ProductMostSellerModel other) {
  //   if (identical(this, other)) return true;
  
  //   return 
  //     other.productName == productName &&
  //     other.productCount == productCount &&
  //     other.productPrice == productPrice &&
  //     other.productImageUrl == productImageUrl;
  // }

  // @override
  // int get hashCode {
  //   return productName.hashCode ^
  //     productCount.hashCode ^
  //     productPrice.hashCode ^
  //     productImageUrl.hashCode;
  // }
}
