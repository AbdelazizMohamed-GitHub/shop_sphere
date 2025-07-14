// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/analytics/data/model/order_over_model.dart';

class CustomOrderOver extends StatelessWidget {
  const CustomOrderOver({
    super.key,
    required this.ordersOver,
    required this.timeRangeIndex,
  });
  final List<OrderOverModel> ordersOver;
  final int timeRangeIndex; // Default to 'day'

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            // 🔘 فلتر زمني

            const SizedBox(height: 20),

            // 📈 رسم بياني Spline Area
            SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: const CategoryAxis(
                title: AxisTitle(text: "Time"),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(text: "Orders"),
              ),
              series: <CartesianSeries>[
                LineSeries<OrderOverModel, String>(
                  dataSource: ordersOver.where((e) => e.count != 0).toList(),
                  xValueMapper: (e, _) =>
                      formatLabel(date: e.time, period: timeRangeIndex),
                  yValueMapper: (e, _) => e.count,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
