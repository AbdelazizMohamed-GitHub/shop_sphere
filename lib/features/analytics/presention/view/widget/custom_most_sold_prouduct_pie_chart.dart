import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';

import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class CustomMostSoldPieChart extends StatefulWidget {
  const CustomMostSoldPieChart({
    super.key,
    required this.products,
  });

  final List<ProductMostSellerModel> products;

  @override
  State<CustomMostSoldPieChart> createState() => _CustomMostSoldPieChartState();
}

class _CustomMostSoldPieChartState extends State<CustomMostSoldPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final displayedProducts = widget.products.take(6).toList();
    final totalCount =
        displayedProducts.fold<int>(0, (sum, p) => sum + p.productCount);

    if (displayedProducts.isEmpty || totalCount == 0) {
      return const Center(
        child: Text(
          'No sales data available',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
         
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    touchedIndex =
                        response?.touchedSection?.touchedSectionIndex ?? -1;
                  });
                },
              ),
              sections: List.generate(displayedProducts.length, (index) {
                final product = displayedProducts[index];
                final isTouched = index == touchedIndex;
                final percentage = ((product.productCount / totalCount) * 100)
                    .toStringAsFixed(1);
                final color =
                    AppFuncations.getColorForProduct(product.productName);

                return PieChartSectionData(
                  value: product.productCount.toDouble(),
                  title: isTouched ? product.productName : '$percentage%',
                  color: color,
                  radius: isTouched ? 70 : 60,
                  titleStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }
}
