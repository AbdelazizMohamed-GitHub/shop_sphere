import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/features/analytics/data/repo_impl/analytics_repo_impl.dart';
import 'package:shop_sphere/features/analytics/presention/contoller/cubit/analytics_cubit.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_chart_title.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sell_prouducts_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_most_sold_prouduct_pie_chart.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_order_over.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/analytics/presention/view/widget/custom_total_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyticsCubit(analyticsRepo: getIt<AnalyticsRepoImpl>())
            ..getAnalyticsData(limit: 10),
      child: Scaffold(
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

              BlocBuilder<AnalyticsCubit, AnalyticsState>(
                builder: (context, state) {
                  return state is AnalyticsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state is AnalyticsError
                          ? Center(child: Text(state.message))
                          : state is AnalyticsLoaded
                              ? Column(
                                  children: [
                                    CustomTotalCard(
                                      totalOrder: state.ordersOver.fold(
                                          0, (sum, order) => sum + order.count),
                                      totalPrice: state.ordersOver.fold(
                                          0,
                                          (sum, order) =>
                                              sum + order.totalCost),
                                    ),
                                    const SizedBox(height: 20),
                                    CustomChartTitle(
                                      title: "Orders Over",
                                      onViewAll: () {
                                        // Handle view all action
                                      },
                                    ),
                                    CustomOrderOver(
                                      ordersOver: state.ordersOver,
                                      timeRangeIndex: context
                                          .read<AnalyticsCubit>()
                                          .timeRangeIndex,
                                    ),
                                    const SizedBox(height: 20),
                                  
                                     CustomMostSoldPieChart(products: state.mostSoldProducts,),
                                    CustomChartTitle(
                                      title: "Most Sold Products",
                                      onViewAll: () {
                                        // Handle view all action
                                      },
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: CustomMostSoldProuductsChart(
                                          products: state.mostSoldProducts),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text('No data available'),
                                );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
