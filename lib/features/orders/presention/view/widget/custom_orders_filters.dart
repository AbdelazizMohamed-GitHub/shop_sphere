
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';


class CustomOrdersFilters extends StatelessWidget {
  final String selectedStatus;
  final String selectedPrice;

  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onPriceChanged;

  const CustomOrdersFilters({
    super.key,
    required this.selectedStatus,
    required this.selectedPrice,
    required this.onStatusChanged,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomDropdown(
            text: 'Select Status',
            isUpdate: false,
            categories: orderStauts
                .map((e) => e.toString())
                .toList(),
            onCategorySelected: onStatusChanged,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: CustomDropdown(
            text: 'Select Price',
            isUpdate: false,
            categories: const [
              'All',
              '0-100',
              '100-1000',
              '1000-more',
            ],
            onCategorySelected: onPriceChanged,
          ),
        ),
      ],
    );
  }
}
