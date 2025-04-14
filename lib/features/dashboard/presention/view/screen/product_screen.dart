import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_cubit.dart';

import '../../../../explor/presention/controller/product_cubit/product_state.dart';
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..getProducts(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: const Text("Products"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              icon: const Icon(Icons.search, size: 30),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<ProductCubit>().getProducts();
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
           
              return state is ProductLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is ProductFailure
                  ? Center(child: Text(state.errMessage))
                  : state is ProductSuccess
                  ? state.products.isEmpty
                      ? const Center(
                        child: Text(
                          "No Products",
                          style: AppStyles.text26BoldBlack,
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomScrollView(
                          slivers: [
                            SliverGrid.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                              itemCount: state.products.length,
                              itemBuilder:
                                  (context, index) => CustomProductItem(
                                    product: state.products[index],
                                  ),
                            ),
                          ],
                        ),
                      )
                  : Container();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductScreen(isUpdate: false),
              ),
            );
          },

          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
