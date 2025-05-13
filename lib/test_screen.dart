// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/warning.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await addDiscontField();
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  Warning.showWarning(context, message: e.toString());
                } finally {
                  // Optionally, you can show a success message or perform any other action here.
                }
              },
              child: const Text("Go to Details"),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

Future<void> addStaffNameToAllProducts() async {
  final productsRef = FirebaseFirestore.instance.collection('products');
  final staffsRef = FirebaseFirestore.instance.collection('users'); // أو users

  final productsSnapshot = await productsRef.get();

  for (final doc in productsSnapshot.docs) {
    final data = doc.data();
    final sId = data['sId'];

    if (sId == null) continue;

    final staffDoc = await staffsRef.doc(sId).get();
    if (!staffDoc.exists) continue;

    final staffName = staffDoc.data()?['name'] ?? 'Unknown';

    // فقط لو staffName مش موجود
    if (!data.containsKey('discount')) {
      await doc.reference.update({'discount': staffName});
      print("✅ Updated product ${doc.id} with staffName: $staffName");
    }
  }

  print("🎉 All products updated!");
}
Future<void> addDiscontField()async {
  final productsRef = FirebaseFirestore.instance.collection('products');
  final productsSnapshot = await productsRef.get();

  for (final doc in productsSnapshot.docs) {
    final data = doc.data();
    if (!data.containsKey('discount')) {
      await doc.reference.update({'discount': getRandomDiscount()});
      print("✅ Updated product ${doc.id} with discount: ${data['discount']}");
    }
  }

  print("🎉 All products updated!");


}
int getRandomDiscount() {
  final discounts = [0, 5, 10, 20, 30, 40];
  final random = Random();
  return discounts[random.nextInt(discounts.length)];
}
