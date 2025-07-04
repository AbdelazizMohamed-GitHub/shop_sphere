// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: handleChangeStaff,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text("Change Staff"),
          ),
          Text("Updated Count: $updatedCount"),
        ],
      ),
    );
  }
}

Future<int> changeStaff() async {
  final productsRef = FirebaseFirestore.instance.collection('products');

  final productsSnapshot = await productsRef
      .where('sId', isEqualTo: '4OPsIIhK9SSKshkXGAfECFT9fQC3')
      .get();

  int updatedCount = 0;

  for (final doc in productsSnapshot.docs) {
    await doc.reference.update({
      'sId': '4cZvO5N8fqg06XDfVvPXEpTNanG3',
      'staffName': 'ShopSphere Staff'
    });
    updatedCount++;
    print("✅ Updated product ${doc.id}");
  }

  print("🎉 Total updated: $updatedCount");
  return updatedCount;
}
