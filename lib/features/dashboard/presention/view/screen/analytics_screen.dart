import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/analytics_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_main_chart.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_data_table.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_total_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _touchedIndex = -1;

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
            IconButton(
                icon: const Icon(Icons.refresh), onPressed: _refreshData),
          ],
        ),
        body: BlocConsumer<AnalyticsCubit, AnalyticsState>(
          listener: (context, state) {
            if (state is AnalyticsError) {
              Warning.showWarning(context, message: state.errMessage);
            }
          },
          builder: (context, state) {
            return state is AnalyticsLoading ? const Center(child: CircularProgressIndicator()) :state is AnalyticsLoaded?  SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time range selector
                  const SizedBox(height: 40, child: CustomTimeRange()),
                  const SizedBox(height: 20),

                  // Metric selector

                  // Summary cards
                  CustomTotalCard(range:state.rangeTotal ,),

                  const SizedBox(height: 20),

                  // Main chart
                  const SizedBox(height: 300, child: CustomMainChart()),
                  const SizedBox(height: 20),

                  // Secondary charts row
                  _buildSecondaryCharts(),
                  const SizedBox(height: 20),

                  // Data table
                  const CustomDataTable(),
                ],
              ),
            ):state is AnalyticsError
                ? CustomErrorWidget(errorMessage: state.errMessage, onpressed: _refreshData,)
                : const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildSecondaryCharts() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(enabled: true),
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
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
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 50.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 60,
            title: '60%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  void _refreshData() {
    // Implement data refresh logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Refreshing data...')));
  }
}
