import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/analytics/data/model/product_most_seller_model.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_product_list.dart';
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
    final isMobile = ResponsiveLayout.isMobile(context);
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

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    color: AppColors.backgroundColor,
                    margin: const EdgeInsets.all(12),
                    child: showPie
                        ? CustomMostSoldPieChart(products: displayedProducts)
                        : CustomMostSoldProuductsChart(
                            products: displayedProducts),
                  ),
                ),
                const SizedBox(height: 16),
                !isMobile
                    ? Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: 230,
                            child: CustomMostSellProductList(
                                products: displayedProducts)),
                      )
                    : const SizedBox()
              ],
            ),

            const SizedBox(height: 16),
            isMobile
                ? CustomMostSellProductList(products: displayedProducts)
                : const SizedBox()
            // ✅ Legend
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
