import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/favourite_repo_impl.dart';
import 'package:shop_sphere/features/explor/data/repo_impl/product_repo_impl.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/cart_cubit/cart_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductCubit(productRepo: getIt<ProductRepoImpl>())
                ..getProducts(category: 'All'),
        ),
        BlocProvider(
          create: (context) =>
              FavouriteCubit(favouriteRepo: getIt<FavouriteRepoImpl>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Text(' Welcome ',
                  style: AppStyles.text18Regular.copyWith(
                    color: AppColors.primaryColor,
                  )),
              Text(
                '${FirebaseAuth.instance.currentUser?.displayName?.split(' ').first}',
                style: AppStyles.text18Regular,
              ),
            ],
          ),
          actions: const [
            CustomAppBarCart(),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Builder(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
            
              await BlocProvider.of<ProductCubit>(context)
                  .getProducts(category: 'All');
            },
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: BlocListener<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is ProductAddedToCart) {
                      Warning.showWarning(
                        context,
                        message: 'Product Added To Cart',
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomExploreScreenSearch(),
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: AppStyles.text22SemiBold,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40, child: CustomCategoryList()),
                      const SizedBox(height: 10),
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return const CustomExploreScreenLoading();
                          } else if (state is ProductFailure) {
                            return CustomErrorWidget(
                              errorMessage: state.errMessage,
                              onpressed: () async {
                                await context
                                    .read<ProductCubit>()
                                    .getProducts(category: 'All');
                              },
                            );
                          } else if (state is ProductSuccess) {
                            if (state.products.isEmpty) {
                              return const Center(
                                child: Text('No Products'),
                              );
                            }

                            final popularProducts = [...state.products]
                              ..shuffle();
                            final sortedProducts = List<ProductEntity>.from(
                                state.products)
                              ..sort(
                                  (a, b) => b.discount.compareTo(a.discount));
                            return Column(
                              children: [
                                CustomAdvertise(
                                  product: sortedProducts,
                                ),
                                CustomProductTitleSection(
                                  title: 'New Arrivals',
                                  funcation: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeeAllScreen(
                                          products: state.products,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                    height: 200,
                                    child: CustomHorzintalProductList(
                                      products: state.products,
                                    )),
                                CustomProductTitleSection(
                                  title: 'Popular Products',
                                  funcation: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeeAllScreen(
                                          products: popularProducts,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CustomVerticalProductList(
                                    products: popularProducts,
                                  ),
                                )
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        }),
      ),
    );
  }
}
