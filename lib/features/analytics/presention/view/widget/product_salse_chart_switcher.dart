import 'package:flutter/material.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_prouducts_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sold_prouduct_pie_chart.dart';

class ProductSalesChartSwitcher extends StatefulWidget {
  const ProductSalesChartSwitcher({super.key, required this.products});

  final List<ProductMostSellerModel> products;

  @override
  State<ProductSalesChartSwitcher> createState() =>
      _ProductSalesChartSwitcherState();
}

class _ProductSalesChartSwitcherState extends State<ProductSalesChartSwitcher> {
  bool showPie = true;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final displayedProducts = getTop5WithOthers(widget.products);
    final totalCount =
        displayedProducts.fold<int>(0, (sum, p) => sum + p.productCount);

    if (displayedProducts.isEmpty || totalCount == 0) {
      return const Center(
        child: Text('No sales data available', style: TextStyle(fontSize: 16)),
      );
    }

    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ عنوان + زر التبديل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Product Sales Distribution',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => setState(() => showPie = !showPie),
                  icon: Icon(showPie ? Icons.bar_chart : Icons.pie_chart),
                  tooltip: showPie ? 'عرض Bar Chart' : 'عرض Pie Chart',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ✅ العرض المتغير بين Pie و Bar
            Card(
              color: AppColors.backgroundColor,
              margin: const EdgeInsets.all(12),
              child: showPie
                  ? CustomMostSoldPieChart(products: displayedProducts)
                  : CustomMostSoldProuductsChart(products: displayedProducts),
            ),

            const SizedBox(height: 16),

            // ✅ Legend
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                final color =
                    AppFuncations.getColorForProduct(product.productName);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                    Text(
                      '${product.productName} (${product.productCount})',
                      style: AppStyles.text14Regular,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<ProductMostSellerModel> getTop5WithOthers(
      List<ProductMostSellerModel> products) {
    if (products.length <= 5) return products;

    final sorted = [...products]
      ..sort((a, b) => b.productCount.compareTo(a.productCount));
    final top5 = sorted.take(5).toList();
    final others = sorted.skip(5);

    final otherCount = others.fold<int>(0, (sum, p) => sum + p.productCount);
    final otherTotalPrice = others.fold<double>(
        0, (sum, p) => sum + (p.productPrice * p.productCount));

    top5.add(ProductMostSellerModel(
      productName: "أخرى",
      productCount: otherCount,
      productPrice: otherCount == 0 ? 0 : otherTotalPrice / otherCount,
      productImageUrl: "",
      productId: '',
    ));

    return top5;
  }
}
