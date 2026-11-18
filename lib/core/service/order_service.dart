import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_sphere/features/explor/data/model/cart_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/cart_entity.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';

class OrderService {
  final FirebaseFirestore firestore ;
  OrderService({required this.firestore});
  
  Future<void> addToCart({required CartItemModel cartItemModel}) async {
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

 



  Future<void> deleteOrder({required OrderModel order}) async {
   
    await firestore.collection("orders").doc(order.orderId).delete();
    await updateStockAfterOrder(isCreateOrder: false, items: order.items);
  }

   Future<void> createOrder({required OrderModel order}) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return; // Ensure user is logged in

    await updateStockAfterOrder(items: order.items, isCreateOrder: true);
    await firestore.collection("orders").doc(order.orderId).set(order.toMap());
    await clearCart();
  }

  Future<void> updateStockAfterOrder(
      {required bool isCreateOrder, required List<CartItemModel> items}) async {
  
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
  Future<void> changeOrdeStatus(
      {required String status,
      required String orderId,
      required int trackingNumber}) async {
    await firestore
        .collection('orders')
        .doc(orderId)
        .update({"status": status, "trackingNumber": trackingNumber});
  }
   Future<List<OrderEntity>> getAllOrders() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("orders").get();
    return querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }
    Future<OrderEntity> getOrderById({required String orderId}) async {
  OrderEntity data=await  FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .get()
        .then((value) {
      if (value.exists) {
        return OrderModel.fromMap(value.data()!);
      } else {
        throw Exception("order not found");
      }
    }).catchError((error) {
      throw Exception("Error fetching Order: $error");
    });
  return data;
  }
  Future<int> getOrdersLength() async {
  
    final aggregateSnapshot =
        await firestore.collection("orders").count().get();
    return aggregateSnapshot.count ?? 0;
  }

 
  Future<double> getOrdersTotalPrice({
    required DateTime start,
    required DateTime end,
  }) async {

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
}