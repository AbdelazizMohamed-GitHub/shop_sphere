import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';

import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/supabase_service.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class FirestoreService {
  FirebaseFirestore firestore;
  FirestoreService({
    required this.firestore,
  });

  Future<void> addProduct(
      {required ProductModel data, required File image}) async {
    await checkInternet();
    String? imageUrl;

    imageUrl = await SupabaseService().uploadImage(file: image);
    data.imageUrl = imageUrl!;

    await firestore.collection('products').doc(data.pId).set(data.toMap());
  }

  Future<List<ProductEntity>> gettProducts({required String category}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    await checkInternet();
    if (category == "All") {
      snapshot = await firestore
          .collection('products')
          .orderBy("createdAt", descending: true)
          .get();
    } else {
      snapshot = await firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
    }

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> deleteProduct(
      {required String dId, required String imageUrl}) async {
    await checkInternet();
    await SupabaseService().deleteImageFromUrl(imageUrl: imageUrl);
    await firestore.collection('products').doc(dId).delete();
  }

  Future<void> updateProduct(
      {required String dId, required ProductModel data}) async {
    await checkInternet();
    await firestore.collection('products').doc(dId).update(data.toMap());
  }

  Future<void> addData(
      {required String collection,
      required String did,
      required UserModel data}) async {
    await checkInternet();
    await firestore.collection(collection).doc(did).set(data.toMap());
  }

  Future<void> updateData(
      {required String collection,
      required String did,
      required UserModel data}) async {
    await checkInternet();
    await firestore.collection(collection).doc(did).update(data.toMap());
  }

  Future<UserEntity> getUserData() async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User is not logged in"); // Ensure user is logged in
    }
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection('users').doc(userId).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("Document not found in collection: users");
    }

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> addAddress(
      {required String addressId, required AddressModel adress}) async {
    await checkInternet();
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .set(adress.toMap());
  }

  Future<void> updateAddress(
      {required String addressId, required AddressModel adress}) async {
    await checkInternet();
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .update(adress.toMap());
  }

  Future<void> deleteAddress({required String addressId}) async {
    await checkInternet();
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .doc(addressId)
        .delete();
  }

  Future<void> updateAddressIndex({required int sellectAddressIndex}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = firestore.collection("users").doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) return; // Handle if user document doesn't exist

    // Update the address index
    await userRef.update({"addressIndex": sellectAddressIndex});
  }

  Future<List<AddressEntity>> getAddress() async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("address")
        .orderBy("createdAt", descending: true)
        .get();
    return querySnapshot.docs
        .map((e) => AddressModel.fromMap(e.data()))
        .toList();
  }

  Future<void> addToFavorite({required String productId}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = firestore.collection("users").doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) return; // Handle if user document doesn't exist

    UserModel userModel =
        UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

    // Toggle favorite status
    if (userModel.favProduct.contains(productId)) {
      userModel.favProduct.remove(productId);
    } else {
      userModel.favProduct.add(productId);
    }

    // Update Firestore with modified favorites
    await userRef.update({"favProduct": userModel.favProduct});
  }

  Future<List<String>> isFavoriteExist({required String productId}) async {
    List<String> favProducts = [];
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return;
      }

      favProducts = List<String>.from(snapshot.data()?['favProduct'] ?? []);
    });
    return favProducts;
  }

  Stream<List<ProductEntity>> getAllFavoriteProducts() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return const Stream.empty();

    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (!snapshot.exists || snapshot.data() == null) return [];

      UserModel userModel =
          UserModel.fromMap(snapshot.data() as Map<String, dynamic>);

      if (userModel.favProduct.isEmpty) {
        return []; // No favorites, return empty list
      }

      // Fetch all favorite products in a single Firestore query
      List<ProductEntity> products = [];
      var productDocs = await firestore
          .collection("products")
          .where('id', whereIn: userModel.favProduct)
          .get();

      for (var doc in productDocs.docs) {
        products.add(ProductModel.fromMap(doc.data()));
      }

      return products;
    });
  }

  Future<void> addToCart({required CartItemModel cartItemModel}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(cartItemModel.id);

    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) {
      await userRef.set(cartItemModel.toMap());
    }
  }

  Future<void> removeFromCart({required String productId}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in
    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  Future<List<CartEntity>> getAllProductsInCart() async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return []; // Ensure user is logged in

    // Fetch all cart items
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .get();

    if (cartSnapshot.docs.isEmpty) return []; // No products in cart

    // Fetch all product details based on IDs

    List<CartEntity> products = cartSnapshot.docs
        .map((doc) => CartItemModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return products;
  }

  Future<CartEntity?> getProductInCart({required String productId}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId)
        .get();

    // Check if document exists
    if (!cartSnapshot.exists || cartSnapshot.data() == null) {
      return null; // or throw an exception
    }

    return CartItemModel.fromMap(cartSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> clearCart() async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<void> updateCartQuantity({
    required String productId,
    required bool isIncrement,
  }) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    DocumentReference cartItemRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId);

    DocumentSnapshot cartSnapshot = await cartItemRef.get();

    if (cartSnapshot.exists) {
      int currentQuantity = cartSnapshot.get("quantity");

      if (isIncrement) {
        // Increase quantity
        await cartItemRef.update({"quantity": currentQuantity + 1});
      } else {
        // Decrease quantity (remove item if quantity is 1)
        if (currentQuantity > 1) {
          await cartItemRef.update({"quantity": currentQuantity - 1});
        } else {
          await cartItemRef.delete();
        }
      }
    }
  }

  Future<void> updateCartQuantityWithCount(
      {required String productId, required int count}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    DocumentReference cartItemRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId);

    DocumentSnapshot cartSnapshot = await cartItemRef.get();

    if (cartSnapshot.exists) {
      await cartItemRef.update({"quantity": count});
    }
  }

  Future<void> createOrder({required OrderModel order}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    await updateStockAfterOrder(items: order.items, isCreateOrder: true);
    await firestore.collection("orders").doc(order.orderId).set(order.toMap());
    await clearCart();
  }

  Future<void> updateStockAfterOrder(
      {required bool isCreateOrder, required List<CartItemModel> items}) async {
    await checkInternet();
    final firestore = FirebaseFirestore.instance;

    for (final item in items) {
      final productRef = firestore.collection('products').doc(item.productId);

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(productRef);

        if (!snapshot.exists) return;

        final currentStock = snapshot.get('stock') as int;
        final orderedQuantity = item.quantity;

        int newStock = isCreateOrder
            ? currentStock - orderedQuantity
            : currentStock + orderedQuantity;

        if (newStock >= 0) {
          transaction.update(productRef, {'stock': newStock});
        } else {
          // Handle case where stock is insufficient
          throw ('Out of stock for Product ${item.name}');
        }
      });
    }
  }

  Future<List<OrderEntity>> getUserOrders({required String status}) async {
    await checkInternet();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (userId == null) return [];

    if (status == "All") {
      querySnapshot = await firestore
          .collection("orders")
          .where("uId", isEqualTo: userId)
          .orderBy("orderDate", descending: true)
          .get();
    } else {
      querySnapshot = await firestore
          .collection("orders")
          .where(
            "status",
            isEqualTo: status,
          )
          .where("uId", isEqualTo: userId)
          .orderBy("orderDate", descending: true)
          .get();
    }
    if (querySnapshot.docs.isEmpty) {
      return []; // Return empty list if no orders found
    }

    return querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Future<void> checkInternet() async {
    bool isOnline = await AppFuncations.isOnline();
    if (!isOnline) {
      FirebaseFailure ( message: '"No Internet Connection"');
    }
  }

  Future<void> deleteOrder({required OrderModel order}) async {
    await checkInternet();
    await firestore.collection("orders").doc(order.orderId).delete();
    await updateStockAfterOrder(isCreateOrder: false, items: order.items);
  }

  Future<void> changeOrdeStatus(
      {required String status,
      required String orderId,
      required int trackingNumber}) async {
    await checkInternet();
    await firestore
        .collection('orders')
        .doc(orderId)
        .update({"status": status, "trackingNumber": trackingNumber});
  }

  Future<List<UserEntity>> getUsers({required bool isStaff}) async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .where("isStaff", isEqualTo: isStaff)
        .get();
 
    return querySnapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future<List<ProductEntity>> getStaffProducts(
      {required String staffId}) async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("products")
        .where(
          "sId",
          isEqualTo: staffId,
        )
        .get();
    return querySnapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  Future<List<OrderEntity>> getAllOrders() async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("orders").get();
    return querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Future<int> getTrackinNumber() async {
    Random random = Random();
    int randomNumber = random
        .nextInt(10000000); // Generate a random number between 0 and 999999

    return randomNumber;
  }

  Future<int> getOrdersLength() async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("orders").get();
    return querySnapshot.docs.length;
  }

  Future<List<OrderEntity>> getCustomerOrder({required String uId}) async {
    await checkInternet();
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('orders').where("uId", isEqualTo: uId).get();
    return querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Future<double> getOrdersTotalPrice({
    required DateTime start,
    required DateTime end,
  }) async {
    await checkInternet();

    final snapshot = await FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "Delivered")
        .where("orderDate", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where("orderDate", isLessThan: Timestamp.fromDate(end))
        .get();

    double total = 0;
    for (var doc in snapshot.docs) {
      total += (doc.data()['totalAmount'] ?? 0) as double;
    }

    return total;
  }

  Future<List<ProductMostSellerModel>> getProductsMostSeller({
    required DateTime start,
    required DateTime end,
    required int limit,
  }) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where("status", isEqualTo: "Delivered")
        .where("orderDate", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where("orderDate", isLessThan: Timestamp.fromDate(end))
        .get();

    // نجمع البيانات كلها (الاسم -> بياناته كاملة)
    final Map<String, ProductMostSellerModel> productMap = {};

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final products = data['items'] as List<dynamic>;

      for (var item in products) {
        final name = item['name'] as String;
        final quantity = item['quantity'] as int;
        final id = item['id'] as String;
       final priceRaw = item['price'];
final price = priceRaw is int ? priceRaw.toDouble() : priceRaw as double;
        final imageUrl = item['imageUrl'] as String;

        if (productMap.containsKey(name)) {
          // زوّد الكمية
          productMap[name] = productMap[name]!.copyWith(
            productCount: productMap[name]!.productCount + quantity,
          );
        } else {
          // أضف منتج جديد
          productMap[name] = ProductMostSellerModel(
            productId: id,
            productName: name,
            productCount: quantity,
            productPrice: price,
            productImageUrl: imageUrl,
          );
        }
      }
    }

    // ترتيب النتائج
    final sorted = productMap.values.toList()
      ..sort((a, b) => b.productCount.compareTo(a.productCount));

    return sorted.take(limit).toList();
  }

  Future<List<ProductMostSellerModel>> getProductsMostSellerTimeRange(
      {required int limit, required int timeRangeIndex}) async {
    DateTime now = DateTime.now();
    DateTime start;
    DateTime end;
    if (timeRangeIndex == 0) {
      start = DateTime(now.year, now.month, now.day);
      end = start.add(const Duration(days: 1));
    } else if (timeRangeIndex == 1) {
      start = now.subtract(const Duration(days: 6));
      start = DateTime(start.year, start.month, start.day);
      end = start.add(const Duration(days: 7));
    } else if (timeRangeIndex == 2) {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month, now.day + 1);
    } else if (timeRangeIndex == 3) {
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year + 1, 1, 1);
    } else {
      return [];
    }

    return getProductsMostSeller(start: start, end: end, limit: limit);
  }

  Future<List<OrderOverModel>> getOrdersOver({
    required DateTime start,
    required DateTime end,
    required int timeRangeIndex,
  }) async {
    await checkInternet();

    final snapshot = await FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "Delivered")
        .where("orderDate", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where("orderDate", isLessThan: Timestamp.fromDate(end))
        .get();

    // تجميع حسب كل ساعة
    Map<DateTime, OrderOverModel> grouped = {};

    if (timeRangeIndex == 0) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final orderDate = (data['orderDate'] as Timestamp).toDate();

        // تعيين بداية الساعة (مثلاً: 13:00:00)
        final hourKey = DateTime(
          orderDate.year,
          orderDate.month,
          orderDate.day,
          orderDate.hour,
        );

        // التعامل الآمن مع totalAmount
        final amountRaw = data['totalAmount'] ?? 0;
        final totalAmount =
            amountRaw is int ? amountRaw.toDouble() : (amountRaw as double);

        if (grouped.containsKey(hourKey)) {
          final existing = grouped[hourKey]!;
          grouped[hourKey] = OrderOverModel(
            time: hourKey,
            count: existing.count + 1,
            totalCost: existing.totalCost + totalAmount,
          );
        } else {
          grouped[hourKey] = OrderOverModel(
            time: hourKey,
            count: 1,
            totalCost: totalAmount,
          );
        }
      }
    } else if (timeRangeIndex == 1) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final orderDate = (data['orderDate'] as Timestamp).toDate();

        // تعيين بداية اليوم
        final dayKey = DateTime(
          orderDate.year,
          orderDate.month,
          orderDate.day,
        );

        // التعامل الآمن مع totalAmount
        final totalAmount = data['totalAmount'] ?? 0;

        if (grouped.containsKey(dayKey)) {
          final existing = grouped[dayKey]!;
          grouped[dayKey] = OrderOverModel(
            time: dayKey,
            count: existing.count + 1,
            totalCost: existing.totalCost + totalAmount,
          );
        } else {
          grouped[dayKey] = OrderOverModel(
            time: dayKey,
            count: 1,
            totalCost: totalAmount,
          );
        }
      }
    } else if (timeRangeIndex == 2) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final orderDate = (data['orderDate'] as Timestamp).toDate();

        final dayKey = DateTime(orderDate.year, orderDate.month, orderDate.day);

        final amountRaw = data['totalAmount'] ?? 0;
        final totalAmount =
            amountRaw is int ? amountRaw.toDouble() : (amountRaw as double);

        if (grouped.containsKey(dayKey)) {
          final existing = grouped[dayKey]!;
          grouped[dayKey] = OrderOverModel(
            time: dayKey,
            count: existing.count + 1,
            totalCost: existing.totalCost + totalAmount,
          );
        } else {
          grouped[dayKey] = OrderOverModel(
            time: dayKey,
            count: 1,
            totalCost: totalAmount,
          );
        }
      }

      // ➕ إكمال أيام الشهر اللي مفيهاش طلبات

      DateTime current = start;
      while (!current.isAfter(end)) {
        grouped.putIfAbsent(
          current,
          () => OrderOverModel(
            time: current,
            count: 0,
            totalCost: 0.0,
          ),
        );
        current = current.add(const Duration(days: 1));
      }
    } else if (timeRangeIndex == 3) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final orderDate = (data['orderDate'] as Timestamp).toDate();

        // تعيين بداية السنة
        final monthKey = DateTime(orderDate.year, orderDate.month);
        // التعامل الآمن مع totalAmount
        final amountRaw = data['totalAmount'] ?? 0;
        final totalAmount =
            amountRaw is int ? amountRaw.toDouble() : (amountRaw as double);

        if (grouped.containsKey(monthKey)) {
          final existing = grouped[monthKey]!;
          grouped[monthKey] = OrderOverModel(
            time: monthKey,
            count: existing.count + 1,
            totalCost: existing.totalCost + totalAmount,
          );
        } else {
          grouped[monthKey] = OrderOverModel(
            time: monthKey,
            count: 1,
            totalCost: totalAmount,
          );
        }
      }
    }

    // ترتيب النتائج حسب الساعة
    final sorted = grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sorted.map((e) => e.value).toList();
  }

  Future<List<OrderOverModel>> getOrdersOverTimeRange(
      {required int timeRangeIndex}) async {
    DateTime now = DateTime.now();
    DateTime start;
    DateTime end;

    if (timeRangeIndex == 0) {
      start = DateTime(now.year, now.month, now.day);
      end = start.add(const Duration(days: 1));
    } else if (timeRangeIndex == 1) {
      start = now.subtract(const Duration(days: 6));
      start = DateTime(start.year, start.month, start.day);
      end = start.add(const Duration(days: 7));
    } else if (timeRangeIndex == 2) {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month, now.day + 1);
    } else if (timeRangeIndex == 3) {
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year + 1, 1, 1);
    } else {
      return [];
    }

    return await getOrdersOver(
        start: start, end: end, timeRangeIndex: timeRangeIndex);
  }
}
