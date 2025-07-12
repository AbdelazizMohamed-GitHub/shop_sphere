import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/analytics/data/model/order_deliverd_data.dart';
import 'package:shop_sphere/test_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomOrderOver extends StatelessWidget {
  const CustomOrderOver({super.key});

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
                LineSeries<OrderDeliverdData, String>(
                  dataSource: AppTestData.dummyOrderData,
                  xValueMapper: (e, _) => formatLabel(date: e.time, period: 1),
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
