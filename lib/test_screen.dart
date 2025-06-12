// ignore_for_file: avoid_print, use_build_context_synchronously

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
  int updatedCount = 0;

  Future<void> handleChangeStaff() async {
    setState(() {
      isLoading = true;
    });

    try {
      final count = await changeStaff();
      setState(() {
        updatedCount = count;
      });

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("✅ تم تحديث $count منتج بنجاح!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Warning.showWarning(context, message: e.toString());
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "تم تحديث: $updatedCount منتج",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: isLoading ? null : handleChangeStaff,
                icon: const Icon(Icons.sync),
                label: const Text("تحديث بيانات المنتجات"),
              ),
              const SizedBox(height: 24),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<int> changeStaff() async {
  final productsRef = FirebaseFirestore.instance.collection('products');

  final productsSnapshot = await productsRef
      .where('sId', isEqualTo: 'p5O7DN4R6WOPl8dvfWlHI6iaHFv1')
      .get();

  int updatedCount = 0;

  for (final doc in productsSnapshot.docs) {
    await doc.reference.update({'sId': '4OPsIIhK9SSKshkXGAfECFT9fQC3'});
    updatedCount++;
    print("✅ Updated product ${doc.id}");
  }

  print("🎉 Total updated: $updatedCount");
  return updatedCount;
}
