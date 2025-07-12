import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/analytics/data/model/order_deliverd_data.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_prouducts_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_total_card.dart';
import 'package:shop_sphere/test_data.dart';
import 'package:shop_sphere/test_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    List<ProductMostSellerModel> products = AppTestData.dummyMostSoldProducts;
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

              const CustomTotalCard(
                totalOrder: 5,
                totalPrice: 1500.0,
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text(
                  'Products Most Seller',
                  style: AppStyles.text18Regular,
                ),
                const Spacer(),
                TextButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  label: const Text("View All"),
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                )
              ]),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomMostSoldProuductsChart(products: products)),
              SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 🔘 فلتر زمني

                      const SizedBox(height: 20),

                      // 📈 رسم بياني Spline Area
                      SfCartesianChart(
                        title: ChartTitle(text: "Orders Over"),
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
                            xValueMapper: (e, _) => formatLabel(e.time),
                            yValueMapper: (e, _) => e.count,
                            markerSettings:
                                const MarkerSettings(isVisible: true),
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // 📊 رسم بياني Bar Chart
}
