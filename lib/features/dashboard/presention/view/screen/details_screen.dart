import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_details_header.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashBoardDetailsScreen extends StatelessWidget {
  const DashBoardDetailsScreen({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDetailsHeader(product: product),

           const   Text(
                "The iPhone 15 Pro is crafted with aerospace-grade titanium, making it lighter yet more durable than ever. Powered by the A17 Pro chip, it delivers unparalleled performance for gaming, photography, and everyday tasks.",
                style: AppStyles.text16Regular,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return state is DashboardLoading
                ?const Center(child: CircularProgressIndicator())
                : CustomButton(
                  onPressed: () async {
                    await context.read<DashboardCubit>().deleteProduct(
                      dId: product.pId,
                      imageUrl: product.imageUrl,
                    );
                    Navigator.pop(context);
                  },
                  text: "Delete",
                );
          },
        ),
      ),
    );
  }
}
