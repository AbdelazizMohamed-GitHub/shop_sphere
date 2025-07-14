import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class CustomMostSoldPieChart extends StatelessWidget {
  const CustomMostSoldPieChart({
    super.key,
    required this.products,
  });

  final List<ProductMostSellerModel> products;

  @override
  Widget build(BuildContext context) {
    final totalCount = products.fold<int>(0, (sum, p) => sum + p.productCount);

    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Product Sales Distribution',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: List.generate(products.length, (index) {
                    final product = products[index];
                    final percentage =
                        ((product.productCount / totalCount) * 100)
                            .toStringAsFixed(1);
                    return PieChartSectionData(
                      value: product.productCount.toDouble(),
                      title: '$percentage%',
                      color: Colors.primaries[index % Colors.primaries.length],
                      radius: 60,
                      titleStyle:
                          const TextStyle(fontSize: 12, color: Colors.white),
                      badgeWidget: Tooltip(
                        message: product.productName,
                        child: const SizedBox(width: 10, height: 10),
                      ),
                    );
                  }),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
