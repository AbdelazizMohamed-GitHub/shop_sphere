import 'package:shop_sphere/features/analytics/data/model/order_deliverd_data.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class AppTestData{
static List<ProductMostSellerModel> dummyMostSoldProducts = [
  ProductMostSellerModel(productName: 'iPhone 15 Pro Max', productCount: 120),
  ProductMostSellerModel(productName: 'Samsung Galaxy S24 Ultra', productCount: 95),
  ProductMostSellerModel(productName: 'Xiaomi Redmi Note 13', productCount: 80),
  ProductMostSellerModel(productName: 'PlayStation 5', productCount: 75),
  ProductMostSellerModel(productName: 'MacBook Air M2', productCount: 65),
  ProductMostSellerModel(productName: 'AirPods Pro', productCount: 50),
  ProductMostSellerModel(productName: 'Smart Watch X', productCount: 45),
  ProductMostSellerModel(productName: 'Bluetooth Speaker', productCount: 40),
  ProductMostSellerModel(productName: 'Gaming Mouse Razer', productCount: 35),
  ProductMostSellerModel(productName: 'Mechanical Keyboard', productCount: 30),
];
static  List<OrderDeliverdData> dummyOrderData = List.generate(7, (index) {
  final date = DateTime.now().subtract(Duration(days: 6 - index)); // آخر 7 أيام
  final count = [10, 15, 7, 12, 20, 5, 18][index];
  final totalCost = [1500.0, 2300.0, 800.0, 1600.0, 3200.0, 600.0, 2700.0][index];

  return OrderDeliverdData(
    time: date,
    totalCost: totalCost,
    count: count,
  );
});


}