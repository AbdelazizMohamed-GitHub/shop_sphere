import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/analytics_cubit/analytics_state.dart';

import 'package:shop_sphere/features/dashboard/presention/view/widget/summary_card.dart';

class CustomTotalCard extends StatelessWidget {
  const CustomTotalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AnalyticsCubit, AnalyticsState, double>(
      selector: (state) {
        return state is AnalyticsTimeRangeLoaded
            ? state.rangeTotal
            : state is AnalyticsLoaded
                ? state.rangeTotal
                : 0.0;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SummaryCard(
                title: 'Total',
                value: state.toString(),
                subtitle: state.toString()),
            const SizedBox(
              width: 20,
            ),
            SummaryCard(
                title: 'average',
                value: state.toString(),
                subtitle: state.toString()),
          ],
        );
      },
    );
  }
}
