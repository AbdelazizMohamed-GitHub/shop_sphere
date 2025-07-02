import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/data/repo_impl/analytics_repo_impl.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_data_table.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_time_range.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_total_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyticsCubit(analyticsRepo: getIt<AnalyticsRepoImpl>())
            ..getAllAnalyticsData(timeRangeIndex: 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analytics Dashboard'),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          ],
        ),
        body: BlocConsumer<AnalyticsCubit, AnalyticsState>(
          listener: (context, state) {
            if (state is AnalyticsError) {
              Warning.showWarning(context, message: state.errMessage);
            }
          },
          builder: (context, state) {
            return state is AnalyticsLoading
                ? const Center(child: CircularProgressIndicator())
                : state is AnalyticsLoaded
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Time range selector
                            const SizedBox(
                                height: 40, child: CustomTimeRange()),
                            const SizedBox(height: 20),

                            // Metric selector

                            // Summary cards
                            CustomTotalCard(
                              range: state.rangeTotal,
                            ),

                            const SizedBox(height: 20),

                            // Main chart

                            // Data table
                            const CustomDataTable(),
                          ],
                        ),
                      )
                    : state is AnalyticsError
                        ? CustomErrorWidget(
                            errorMessage: state.errMessage,
                            onpressed: () {},
                          )
                        : const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
