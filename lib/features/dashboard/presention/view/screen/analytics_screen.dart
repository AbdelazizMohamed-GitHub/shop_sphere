import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/analytics_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_total_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<int> days = [];
  List<String> products = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyticsCubit(analyticsRepo: getIt<AnalyticsRepoImpl>())
            ..getAllAnalyticsData(timeRangeIndex: 2),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analytics Dashboard'),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          ],
        ),
        body: BlocConsumer<AnalyticsCubit, AnalyticsState>(
          listener: (context, state) {
            if (state is AnalyticsError) {
              Warning.showWarning(context, message: state.errMessage);
            }
            if (state is AnalyticsLoaded) {
              days = state.days;
              products = state.products;
              print(products[2]);
            }
          },
          builder: (context, state) {
            if (state is AnalyticsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AnalyticsLoaded ||
                state is AnalyticsTimeRangeLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time range selector
                    const SizedBox(height: 40, child: CustomTimeRange()),
                    const SizedBox(height: 20),

                    const CustomTotalCard(),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 300,
                        width: products.length * 60, //
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            minY: 0,
                            gridData: const FlGridData(show: true),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                axisNameWidget: const Text(''),
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    if (value.toInt() < products.length) {
                                      return Text(
                                        products[value.toInt()].toString(),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      );
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                  reservedSize: 28,
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true, reservedSize: 40),
                              ),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: products.asMap().entries.map((entry) {
                              int index = entry.key;
                              String product = entry.value;
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: 100,
                                    color: Colors.blue,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('No data available'),
            );
            //   return  CustomErrorWidget(errorMessage: '', onpressed: () {  },);
          },
        ),
      ),
    );
  }
}
