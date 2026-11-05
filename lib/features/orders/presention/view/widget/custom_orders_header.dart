
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomOrdersHeader extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final int filteredCount;
  final bool isSearching;

  const CustomOrdersHeader({
    super.key,
    required this.onSearchChanged,
    required this.filteredCount,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextForm(
            onChanged: onSearchChanged,
            pIcon: Icons.search_rounded,
            text: 'Search for order & customer',
            kType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 16),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is GetOrderLoading) {
              return const Skeletonizer(
                enabled: true,
                child: Text('Loading Orders'),
              );
            }

            return Text(
              '$filteredCount Orders',
              style: AppStyles.text22SemiBold,
            );
          },
        ),
      ],
    );
  }
}
