import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/analytics/presention/view/widget/summary_card.dart';

class CustomTotalCard extends StatelessWidget {
  const CustomTotalCard({
    super.key, required this.totalOrder, required this.totalPrice,
  });
  final int totalOrder;
  final double totalPrice;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SummaryCard(
            title: 'Total',
            value: totalOrder.toString(),
            subtitle: 'Orders'),
        const SizedBox(
          width: 20,
        ),
        SummaryCard(
            title: 'Total Price',
            value: totalPrice.toStringAsFixed(2),
            subtitle: 'EGP'),
      ],
    );
  }
}
