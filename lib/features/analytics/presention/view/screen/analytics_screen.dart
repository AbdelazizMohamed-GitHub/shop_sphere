import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_total_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analytics Dashboard'),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time range selector
              const SizedBox(height: 40, child: CustomTimeRange()),
              const SizedBox(height: 20),

              CustomTotalCard(
                totalOrder: 5,
                totalPrice: state.rangeTotal,
              ),
              const SizedBox(height: 20),
              Row(children: [
                Text(
                  'Products Most Seller',
                  style: AppStyles.text18Regular,
                ),
                const Spacer(),
                TextButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  label: Text("View All"),
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                )
              ]),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 300,
                  width: state.products.length < 8
                      ? MediaQuery.of(context).size.width - 30
                      : state.products.length * 50.0,
                  child: Card(
                    color: AppColors.backgroundColor,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: BarChart(
                        BarChartData(
                          minY: 0,
                          maxY: state.products.isNotEmpty
                              ? state.products.length + 10
                              : 0,
                          alignment: BarChartAlignment.spaceAround,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= state.products.length) {
                                    return const SizedBox();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      state.products[index].productName.length >
                                              10
                                          ? '${state.products[index].productName.substring(0, 10)}...'
                                          : state.products[index].productName,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  }),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          barGroups:
                              List.generate(state.products.length, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: state.products[index].productCount
                                      .toDouble(),
                                  color: Colors.blueAccent,
                                  width: 16,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),

               
              ),
            ],
          ),
        ));
  }
}
