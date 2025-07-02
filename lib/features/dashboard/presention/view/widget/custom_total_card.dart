// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/features/dashboard/presention/view/widget/summary_card.dart';

class CustomTotalCard extends StatelessWidget {
  const CustomTotalCard({
    super.key,
    required this.range,
  });
  final double range;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SummaryCard(
            title: 'Total',
            value: range.toString(),
            subtitle: range.toString()),
        const SizedBox(
          width: 20,
        ),
        SummaryCard(
            title: 'average',
            value: range.toString(),
            subtitle: range.toString()),
      ],
    );
  }
}
