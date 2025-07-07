// // // ignore_for_file: avoid_print, use_build_context_synchronously

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shop_sphere/core/service/firestore_service.dart';
// // import 'package:shop_sphere/features/dashboard/data/model/product_most_seller_model.dart';

// // class TestScreen extends StatefulWidget {
// //   const TestScreen({super.key});

// //   @override
// //   State<TestScreen> createState() => _TestScreenState();
// // }

// // class _TestScreenState extends State<TestScreen> {
// //   String label = '';
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Test Screen"),
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           ElevatedButton(
// //             onPressed: () async {
// //               List<ProductMostSellerModel> data = await FirestoreService(
// //                       firestore: FirebaseFirestore.instance)
// //                   .getProductsMostSellerTimeRange(limit: 10, timeRangeIndex: 3);
// //               print(data.length);
// //               setState(() {});
// //             },
// //             child: const Text("Process"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:shop_sphere/core/service/firestore_service.dart';
// import 'package:shop_sphere/features/dashboard/data/model/product_most_seller_model.dart';

// enum TimeFilter {
//   today,
//   week,
//   month,
// }

// extension TimeFilterExtension on TimeFilter {
//   String get label {
//     switch (this) {
//       case TimeFilter.today:
//         return 'اليوم';
//       case TimeFilter.week:
//         return 'آخر 7 أيام';
//       case TimeFilter.month:
//         return 'هذا الشهر';
//     }
//   }
// }

// class AnalyticsScreenTest extends StatefulWidget {
//   const AnalyticsScreenTest({super.key});

//   @override
//   State<AnalyticsScreenTest> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreenTest> {
//   late Future<List<ProductMostSellerModel>> _productsFuture;
//   TimeFilter _selectedFilter = TimeFilter.week;

//   @override
//   void initState() {
//     super.initState();
//     _fetchMostSoldProducts();
//   }

//   void _fetchMostSoldProducts() {
//     final now = DateTime.now();
//     DateTime start;

//     switch (_selectedFilter) {
//       case TimeFilter.today:
//         start = DateTime(now.year, now.month, now.day);
//         break;
//       case TimeFilter.week:
//         start = now.subtract(const Duration(days: 7));
//         break;
//       case TimeFilter.month:
//         start = DateTime(now.year, now.month, 1);
//         break;
//     }

//     _productsFuture = FirestoreService(firestore: FirebaseFirestore.instance)
//         .getProductsMostSellerTimeRange(limit: 10, timeRangeIndex: 2);
//   }

//   void _onFilterChanged(TimeFilter newFilter) {
//     setState(() {
//       _selectedFilter = newFilter;
//       _fetchMostSoldProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إحصائيات المبيعات'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<ProductMostSellerModel>>(
//         future: _productsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("خطأ: ${snapshot.error}"));
//           }

//           final products = snapshot.data!;
//           if (products.isEmpty) {
//             return const Center(child: Text("لا توجد مبيعات في هذه الفترة."));
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // فلتر الفترات الزمنية
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const Text("الفترة: "),
//                     DropdownButton<TimeFilter>(
//                       value: _selectedFilter,
//                       onChanged: (value) {
//                         if (value != null) _onFilterChanged(value);
//                       },
//                       items: TimeFilter.values.map((filter) {
//                         return DropdownMenuItem(
//                           value: filter,
//                           child: Text(filter.label),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // الرسم البياني
//                 Expanded(
//                   flex: 2,
//                   child: BarChart(
//                     BarChartData(
//                       alignment: BarChartAlignment.spaceAround,
//                       barTouchData: BarTouchData(enabled: true),
//                       titlesData: FlTitlesData(
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             getTitlesWidget: (value, meta) {
//                               final index = value.toInt();
//                               if (index >= products.length)
//                                 return const SizedBox();
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Text(
//                                   products[index].productName.length > 6
//                                       ? products[index]
//                                               .productName
//                                               .substring(0, 6) +
//                                           '...'
//                                       : products[index].productName,
//                                   style: const TextStyle(fontSize: 10),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: true),
//                         ),
//                         topTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         rightTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                       ),
//                       borderData: FlBorderData(show: false),
//                       barGroups: List.generate(products.length, (index) {
//                         return BarChartGroupData(
//                           x: index,
//                           barRods: [
//                             BarChartRodData(
//                               toY: products[index].productCount.toDouble(),
//                               color: Colors.blueAccent,
//                               width: 16,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // قائمة المنتجات
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return Card(
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.blueAccent,
//                             child: Text("${index + 1}"),
//                           ),
//                           title: Text(product.productName),
//                           trailing: Text("${product.productCount} قطعة"),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
