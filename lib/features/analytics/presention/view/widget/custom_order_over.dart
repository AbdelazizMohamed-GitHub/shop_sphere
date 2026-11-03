// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:shop_sphere/core/theme/app_color.dart';
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
              tooltipBehavior: TooltipBehavior(
                enable: true,
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  final order = data as OrderOverModel;
                  // لو اليوم الحالي (timeRangeIndex == 0) نعرض الساعة
                  final timeLabel = timeRangeIndex == 0
                      ? '${order.time.hour}:00'
                      : formatLabel(date: order.time, period: timeRangeIndex);

                  return Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$timeLabel\nOrders: ${order.count}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                },
              ),
              primaryXAxis: const CategoryAxis(
                title: AxisTitle(text: "Time"),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(text: "Orders"),
              ),
              series: <CartesianSeries>[
                LineSeries<OrderOverModel, String>(
                  name: 'Orders Over Time',
                  color: AppColors.primaryColor,
                  dataSource: timeRangeIndex == 0
                      ? ordersOver
                      : AppFuncations.fillMissing(ordersOver, timeRangeIndex),
                  xValueMapper: (e, _) =>
                      formatLabel(date: e.time, period: timeRangeIndex),
                  yValueMapper: (e, _) => e.count,
                  dataLabelMapper: (OrderOverModel e, _) =>
                      e.count == 0 ? '' : e.count.toString(),
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
