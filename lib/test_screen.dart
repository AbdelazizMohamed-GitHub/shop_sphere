// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {await getProductsMostSeller( limit: 10,
                start: DateTime.now().subtract(const Duration(days: 7)),
                end: DateTime.now());
            },
            child: const Text("Change Staff"),
          ),
        ],
      ),
    );
  }
}

Future<List<String>> getProductsMostSeller(
    {required DateTime start, required DateTime end, required int limit}) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "Delivered")
      .where("orderDate", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
      .where("orderDate", isLessThan: Timestamp.fromDate(end)).limit(limit)
      .get();
  Map<String, int> productCount = {};
  for (var doc in snapshot.docs) {
    final data = doc.data();
    final products = data['items'];
    for (var item in products) {
      final productId = item['name'] as String;
      productCount[productId] = (productCount[productId] ?? 0) + 1;
    }
  }
  List<String> mostSoldProducts = [];
  productCount.entries
      .toList()
      .sort((a, b) => b.value.compareTo(a.value)); // Sort by count descending
  mostSoldProducts = productCount.entries.map((entry) => entry.key).toList();
  return mostSoldProducts;
}
