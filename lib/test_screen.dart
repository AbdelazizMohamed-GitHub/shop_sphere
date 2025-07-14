// // // // ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_prouducts_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_order_over.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<ProductMostSellerModel> data = [];
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
          Center(
            child: ElevatedButton(
              onPressed: () async {
                data = await FirestoreService(
                        firestore: FirebaseFirestore.instance)
                    .getProductsMostSellerTimeRange(timeRangeIndex: 3, limit: 10);
                if (data.isEmpty) {
                  print("No orders found for today.");
                  return;
                }
                setState(() {});

                for (var i = 0; i < data.length; i++) {
                  print(
                      "${data[i].productName} | ${data[i].productPrice}: ${data[i].productCount} orders, Total Cost: ${data[i].productImageUrl}");
                }
              },
              child: const Text("Process"),
            ),
          ),
          const SizedBox(height: 20),
          CustomMostSoldProuductsChart(
             products: data,
          
          ),
        ],
      ),
    );
  }
}
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:shop_sphere/core/service/firestore_service.dart';
// // import 'package:shop_sphere/features/dashboard/data/model/product_most_seller_model.dart';

// // enum TimeFilter {
// //   today,
// //   week,
// //   month,
// // }

// // extension TimeFilterExtension on TimeFilter {
// //   String get label {
// //     switch (this) {
// //       case TimeFilter.today:
// //         return 'اليوم';
// //       case TimeFilter.week:
// //         return 'آخر 7 أيام';
// //       case TimeFilter.month:
// //         return 'هذا الشهر';
// //     }
// //   }
// // }

// // class AnalyticsScreenTest extends StatefulWidget {
// //   const AnalyticsScreenTest({super.key});

// //   @override
// //   State<AnalyticsScreenTest> createState() => _AnalyticsScreenState();
// // }

// // class _AnalyticsScreenState extends State<AnalyticsScreenTest> {
// //   late Future<List<ProductMostSellerModel>> _productsFuture;
// //   TimeFilter _selectedFilter = TimeFilter.week;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchMostSoldProducts();
// //   }

// //   void _fetchMostSoldProducts() {
// //     final now = DateTime.now();
// //     DateTime start;

// //     switch (_selectedFilter) {
// //       case TimeFilter.today:
// //         start = DateTime(now.year, now.month, now.day);
// //         break;
// //       case TimeFilter.week:
// //         start = now.subtract(const Duration(days: 7));
// //         break;
// //       case TimeFilter.month:
// //         start = DateTime(now.year, now.month, 1);
// //         break;
// //     }

// //     _productsFuture = FirestoreService(firestore: FirebaseFirestore.instance)
// //         .getProductsMostSellerTimeRange(limit: 10, timeRangeIndex: 2);
// //   }

// //   void _onFilterChanged(TimeFilter newFilter) {
// //     setState(() {
// //       _selectedFilter = newFilter;
// //       _fetchMostSoldProducts();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('إحصائيات المبيعات'),
// //         centerTitle: true,
// //       ),
// //       body: FutureBuilder<List<ProductMostSellerModel>>(
// //         future: _productsFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text("خطأ: ${snapshot.error}"));
// //           }

// //           final products = snapshot.data!;
// //           if (products.isEmpty) {
// //             return const Center(child: Text("لا توجد مبيعات في هذه الفترة."));
// //           }

// //           return Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               children: [
// //                 // فلتر الفترات الزمنية
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.end,
// //                   children: [
// //                     const Text("الفترة: "),
// //                     DropdownButton<TimeFilter>(
// //                       value: _selectedFilter,
// //                       onChanged: (value) {
// //                         if (value != null) _onFilterChanged(value);
// //                       },
// //                       items: TimeFilter.values.map((filter) {
// //                         return DropdownMenuItem(
// //                           value: filter,
// //                           child: Text(filter.label),
// //                         );
// //                       }).toList(),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 20),

// //                 // الرسم البياني
// //                 Expanded(
// //                   flex: 2,
// //                   child: BarChart(
// //                     BarChartData(
// //                       alignment: BarChartAlignment.spaceAround,
// //                       barTouchData: BarTouchData(enabled: true),
// //                       titlesData: FlTitlesData(
// //                         bottomTitles: AxisTitles(
// //                           sideTitles: SideTitles(
// //                             showTitles: true,
// //                             getTitlesWidget: (value, meta) {
// //                               final index = value.toInt();
// //                               if (index >= products.length)
// //                                 return const SizedBox();
// //                               return Padding(
// //                                 padding: const EdgeInsets.only(top: 8),
// //                                 child: Text(
// //                                   products[index].productName.length > 6
// //                                       ? products[index]
// //                                               .productName
// //                                               .substring(0, 6) +
// //                                           '...'
// //                                       : products[index].productName,
// //                                   style: const TextStyle(fontSize: 10),
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                         leftTitles: AxisTitles(
// //                           sideTitles: SideTitles(showTitles: true),
// //                         ),
// //                         topTitles: AxisTitles(
// //                             sideTitles: SideTitles(showTitles: false)),
// //                         rightTitles: AxisTitles(
// //                             sideTitles: SideTitles(showTitles: false)),
// //                       ),
// //                       borderData: FlBorderData(show: false),
// //                       barGroups: List.generate(products.length, (index) {
// //                         return BarChartGroupData(
// //                           x: index,
// //                           barRods: [
// //                             BarChartRodData(
// //                               toY: products[index].productCount.toDouble(),
// //                               color: Colors.blueAccent,
// //                               width: 16,
// //                               borderRadius: BorderRadius.circular(4),
// //                             ),
// //                           ],
// //                         );
// //                       }),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // قائمة المنتجات
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: products.length,
// //                     itemBuilder: (context, index) {
// //                       final product = products[index];
// //                       return Card(
// //                         child: ListTile(
// //                           leading: CircleAvatar(
// //                             backgroundColor: Colors.blueAccent,
// //                             child: Text("${index + 1}"),
// //                           ),
// //                           title: Text(product.productName),
// //                           trailing: Text("${product.productCount} قطعة"),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:syncfusion_flutter_charts/charts.dart' as charts;
// import 'package:flutter/material.dart';

// class OrderChartData {
//   final String label;
//   final int count;

//   OrderChartData({required this.label, required this.count});
// }

// class OrdersAnalyticsScreen extends StatefulWidget {
//   const OrdersAnalyticsScreen({super.key});

//   @override
//   State<OrdersAnalyticsScreen> createState() => _OrdersAnalyticsScreenState();
// }

// class _OrdersAnalyticsScreenState extends State<OrdersAnalyticsScreen> {
//   String selectedPeriod = 'day'; // default
//   late Future<List<OrderChartData>> _chartFuture;

//   @override
//   void initState() {
//     super.initState();
//     _chartFuture = getOrdersGroupedBy(period: selectedPeriod);
//   }

//   Future<List<OrderChartData>> getOrdersGroupedBy({
//     required String period,
//   }) async {
//     final now = DateTime.now();
//     DateTime start;

//     if (period == 'day') {
//       start = DateTime(now.year, now.month, now.day);
//     } else if (period == 'week') {
//       start = now.subtract(Duration(days: now.weekday ));
//     } else if (period == 'month') {
//       start = DateTime(now.year, now.month, 1);
//     } else {
//       start = DateTime(now.year, 1, 1);
//     }

//     final snapshot = await FirebaseFirestore.instance
//         .collection('orders')
//         .where("status", isEqualTo: "Delivered") // ✔️ تعديل الحالة حسب الحاجة
//         .where("orderDate", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
//         .where("orderDate", isLessThanOrEqualTo: Timestamp.fromDate(now))
//         .get();

//     final Map<String, int> counts = {};

//     for (var doc in snapshot.docs) {
//       final date = (doc.data()['orderDate'] as Timestamp).toDate();
//       String label;

//       switch (period) {
//         case 'day':
//           label = '${date.hour}:00';
//           break;
//         case 'week':
//           label = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday ];
//           break;
//         case 'month':
//           label = '${date.day}';
//           break;
//         case 'year':
//           label = '${date.month}';
//           break;
//         default:
//           label = 'N/A';
//       }

//       counts[label] = (counts[label] ?? 0) + 1;
//     }

//     // ترتيب القيم على حسب نوع الفلترة
//     final sorted = counts.entries.toList()
//       ..sort((a, b) => a.key.compareTo(b.key));

//     return sorted.map((e) => OrderChartData(label: e.key, count: e.value)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders Analysis'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 🔘 فلتر الفترات الزمنية
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Filter By:", style: TextStyle(fontSize: 16)),
//                 DropdownButton<String>(
//                   value: selectedPeriod,
//                   items: ['day', 'week', 'month', 'year']
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
//                       .toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       setState(() {
//                         selectedPeriod = value;
//                         _chartFuture = getOrdersGroupedBy(period: value);
//                       });
//                     }
//                   },
//                 )
//               ],
//             ),
//             const SizedBox(height: 16),

//             // 📊 الرسم البياني
//             FutureBuilder<List<OrderChartData>>(
//               future: _chartFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Text("No orders found for this period.");
//                 }

//                 final data = snapshot.data!;
//                 final maxY = data.map((e) => e.count).reduce((a, b) => a > b ? a : b).toDouble();
//                 final interval = maxY <= 10
//                     ? 1
//                     : maxY <= 50
//                         ? 10
//                         : maxY <= 100
//                             ? 20
//                             : 50;

//               return SizedBox(
//                 height: 300,
//                 child: charts.SplineAreaSeries(
//                   primaryXAxis: charts.CategoryAxis(),
//                   primaryYAxis: charts.NumericAxis(
//                     interval: 20,
//                     title: charts.AxisTitle(text: 'Order Count'),
//                   ),
//                   series: <charts.CartesianSeries>[
//                     charts.ColumnSeries<OrderChartData, String>(
//                       dataSource: data,
//                       xValueMapper: (OrderChartData order, _) => order.label,
//                       yValueMapper: (OrderChartData order, _) => order.count,
//                       name: 'Orders',
//                       color: Colors.deepPurple,
//                     ),
//                   ],
//                   tooltipBehavior: charts.TooltipBehavior(enable: true),
//                 ),
//               );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';

class OrderTrendData {
  final DateTime date;
  final int orders;

  OrderTrendData(this.date, this.orders);
}

class OrdersSplineChartScreen extends StatefulWidget {
  const OrdersSplineChartScreen({super.key});

  @override
  State<OrdersSplineChartScreen> createState() =>
      _OrdersSplineChartScreenState();
}

class _OrdersSplineChartScreenState extends State<OrdersSplineChartScreen> {
  String selectedPeriod = 'day';
  late Future<List<OrderTrendData>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getOrderTrendData('year'); // default to year
  }

  Future<List<OrderTrendData>> getOrderTrendData(String period) async {
    final now = DateTime.now();
    late DateTime start;

    if (period == 'day') {
      start = DateTime(now.year, now.month, now.day);
    } else if (period == 'week') {
      start = now.subtract(Duration(days: now.weekday - 1));
    } else if (period == 'month') {
      start = DateTime(now.year, now.month, 1);
    } else {
      start = DateTime(now.year, 1, 1);
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Delivered')
        .where('orderDate', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('orderDate', isLessThanOrEqualTo: Timestamp.fromDate(now))
        .get();

    final Map<DateTime, int> grouped = {};

    for (var doc in snapshot.docs) {
      final date = (doc['orderDate'] as Timestamp).toDate();

      DateTime key;
      switch (period) {
        case 'day':
          key = DateTime(date.year, date.month, date.day, date.hour);
          break;
        case 'week':
        case 'month':
          key = DateTime(date.year, date.month, date.day);
          break;
        case 'year':
          key = DateTime(date.year, date.month);
          break;
        default:
          key = date;
      }

      grouped[key] = (grouped[key] ?? 0) + 1;
    }

    final sorted = grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sorted.map((e) => OrderTrendData(e.key, e.value)).toList();
  }

  String formatLabel(DateTime date) {
    switch (selectedPeriod) {
      case 'day':
        return DateFormat.Hm().format(date); // الساعة
      case 'week':
        return DateFormat.E().format(date); // Mon, Tue...
      case 'month':
        return DateFormat.Md().format(date); // 7/5
      case 'year':
        return DateFormat.MMM().format(date); // Jan, Feb...
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Trend'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔘 فلتر زمني
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter By:", style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: selectedPeriod,
                  items: ['day', 'week', 'month', 'year']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPeriod = value;
                        _futureData = getOrderTrendData(selectedPeriod);
                      });
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20),

            // 📈 رسم بياني Spline Area
            Expanded(
              child: FutureBuilder<List<OrderTrendData>>(
                future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data ?? [];
                  if (data.isEmpty) {
                    return const Center(child: Text("No data available."));
                  }

                  return SfCartesianChart(
                    title: ChartTitle(
                        text: "Orders Over ${selectedPeriod.toUpperCase()}"),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryXAxis: const CategoryAxis(
                      title: AxisTitle(text: "Time"),
                    ),
                    primaryYAxis: const NumericAxis(
                      title: AxisTitle(text: "Orders"),
                    ),
                    series: <CartesianSeries>[
                      LineSeries<OrderTrendData, String>(
                        dataSource: data,
                        xValueMapper: (e, _) => formatLabel(e.date),
                        yValueMapper: (e, _) => e.orders,
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
