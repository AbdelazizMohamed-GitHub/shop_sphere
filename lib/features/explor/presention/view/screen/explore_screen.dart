import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/product_repo_impl.dart';
import 'package:shop_sphere/features/explor/presention/controller/favourite_cubit/favourite_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/product_cubit/product_state.dart';
import 'package:shop_sphere/features/explor/presention/view/screen/see_all_screen.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_advertise.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_app_bar_cart.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_category_list.dart';
import 'package:shop_sphere/core/loading/custom_explore_screen_loading.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_explore_screen_search.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_new_arrivels_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_popular_product_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_product_title_section.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(productRepo: getIt<ProductRepoImpl>())
        ..getProducts(category: 'All'),
      child: BlocProvider(
        create: (context) => FavouriteCubit(
          favouriteRepo: getIt<FavouriteRepoImpl>(),
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'Explore',
            ),
            actions: const [
              CustomAppBarCart(),
              SizedBox(
                width: 20,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  const CustomExploreScreenSearch(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          'Categories',
                          style: AppStyles.text22SemiBoldBlack.copyWith(
                            color: AppTheme.isLightTheme(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40, child: CustomCategoryList()),
                  const SizedBox(height: 10),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      return state is ProductLoading
                          ? const CustomExploreScreenLoading()
                          : state is ProductFailure
                              ? Column(children: [
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      state.errMessage,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await context
                                          .read<ProductCubit>()
                                          .getProducts(category: 'All');
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ])
                              : state is ProductSuccess
                                  ? state.products.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                            ),
                                            Text('No products found'),
                                          ],
                                        )
                                      : RefreshIndicator(
                                          onRefresh: () async {
                                            await context
                                                .read<ProductCubit>()
                                                .getProducts(category: 'All');
                                          },
                                          child: Column(
                                            children: [
                                              CustomAdvertise(
                                                product: state.products.first,
                                              ),
                                              CustomProductTitleSection(
                                                title: 'New Arrivals',
                                                funcation: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllScreen(
                                                        products:
                                                            state.products,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                  height: 200,
                                                  child:
                                                      CustomHorzintalProductList(
                                                    products: state.products,
                                                  )),
                                              CustomProductTitleSection(
                                                title: 'Popular Products',
                                                funcation: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllScreen(
                                                        products:
                                                            state.products,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child:
                                                    CustomVerticalProductList(
                                                  products: state.products,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                  : SizedBox();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
