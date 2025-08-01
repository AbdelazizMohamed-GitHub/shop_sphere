import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class CustomMostSoldProuductsChart extends StatelessWidget {
  const CustomMostSoldProuductsChart({
    super.key,
    required this.products,
  });
  final List<ProductMostSellerModel> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: products.isNotEmpty
                ? products
                        .map((e) => e.productCount)
                        .reduce((a, b) => a > b ? a : b) +
                    10
                : 0,
            alignment: BarChartAlignment.spaceAround,
            groupsSpace: 12,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final product = products[group.x.toInt()];
                  return BarTooltipItem(
                    '${product.productName}\n',
                    const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '${product.productCount} sold',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= products.length) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Transform.rotate(
                        angle: -0.5,
                        child: Text(
                          products[index].productName.length > 10
                              ? '${products[index].productName.substring(0, 10)}...'
                              : products[index].productName,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      );
                    }),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                )),
            barGroups: List.generate(products.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: products[index].productCount.toDouble(),
                    color:AppFuncations.getColorForProduct(products[index].productName) ,
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
