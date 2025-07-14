import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';

class CustomMostSoldPieChart extends StatelessWidget {
  const CustomMostSoldPieChart({
    super.key,
    required this.products,
  });

  final List<ProductMostSellerModel> products;

  @override
  Widget build(BuildContext context) {
    final displayedProducts = products.take(6).toList();
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
              sections: List.generate(displayedProducts.length, (index) {
                final product = displayedProducts[index];
                final percentage = ((product.productCount / totalCount) * 100)
                    .toStringAsFixed(1);
                final color = AppFuncations.getColorForProduct(product.productName);
    
                return PieChartSectionData(
                  value: product.productCount.toDouble(),
                  title: '$percentage%',
                  color: color,
                  radius: 60,
                  titleStyle:
                      const TextStyle(fontSize: 12, color: Colors.white),
                );
              }),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
       
       
    
        // 🎨 Legend
      ],
    );
  }

  /// 🎯 يرجع أول 5 منتجات ويجمع الباقي في "أخرى"
}
