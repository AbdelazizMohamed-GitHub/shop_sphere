import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/analytics/data/model/order_deliverd_data.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_chart_title.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_prouducts_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_order_over.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_total_card.dart';
import 'package:shop_sphere/test_data.dart';
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
            CustomChartTitle(
              title: "Most Sold Products",
              onViewAll: () {
                // Handle view all action
              },
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomMostSoldProuductsChart(products: products)),

            CustomChartTitle(
              title: "Orders Over",
              onViewAll: () {
                // Handle view all action
              },
            ),
          CustomOrderOver(),
          ],
        ),
      ),
    );
  }
}
