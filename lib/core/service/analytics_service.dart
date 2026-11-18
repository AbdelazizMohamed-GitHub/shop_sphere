import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class AnalyticsService {
  final FirebaseFirestore firestore;
  AnalyticsService({required this.firestore});
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
        final price =
            priceRaw is int ? priceRaw.toDouble() : priceRaw as double;
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