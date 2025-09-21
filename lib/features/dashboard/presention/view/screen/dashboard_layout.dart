// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/analytics/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_body.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_drawer.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';

class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({
    super.key,
  });

  @override
  State<DashBoardLayout> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<DashBoardLayout> {
  String selectedCategory = "All";
  @override
  void initState() {
    final savedIndex =
        Hive.box(AppConst.dashboardScreen).get('index', defaultValue: 0);
    context.read<DashboardCubit>().changeScreenIndex(savedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('products')
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
            body: CustomErrorWidget(
              errorMessage: snapshot.error.toString(),
              onpressed: () {
                setState(() {});
              },
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Scaffold(body: Center(child: Text("No Products Found")));
        } else {
          final List<ProductEntity> products = snapshot.data!.docs
              .map((doc) => ProductModel.fromMap(doc.data()))
              .toList();

          if (selectedCategory != "All") {
            products.retainWhere((product) =>
                product.category.toLowerCase() ==
                selectedCategory.toLowerCase());
          }

          final List<ProductEntity> outOfStock =
              products.where((product) => product.stock == 0).toList();

          final isDesktop = ResponsiveLayout.isDesktop(context);

          final List<Widget> dashboardScreens = [
            CustomProductScreenBody(
              products: products,
              onCategoryChanged: (String value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const OrdersScreen(),
            const UsersScreen(),
            const AnalyticsScreen(),
            OutOfStockScreen(products: outOfStock),
          ];

          return BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar: isDesktop || state.screenIndex!=0
                    ? null
                    : AppBar(
                        title:  Text(" ${products.length} Products",style: AppStyles.text18Regular,),
                        actions: [
                         
                          IconButton(
                            onPressed: () {
                              context.goNamed(AppRoute.search);
                            },
                            icon: const Icon(Icons.search, size: 30),
                          ),
                          PopupMenuButton(
                              child: const Icon(Icons.filter_list),
                              itemBuilder: (context) =>
                                  appCategory.map((category) {
                                    return PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          selectedCategory = category;
                                        });
                                      },
                                      value: category,
                                      child: Text(category),
                                    );
                                  }).toList()),
                          const SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                drawer: isDesktop
                    ? null
                    : CustomProductScreenDrawer(outOfStock: outOfStock, products: products, onCategoryChanged: (String value) { 
                        setState(() {
                          selectedCategory = value;
                        });
                     },),
                body: Row(
                  children: [
                    if (isDesktop)
                      SizedBox(
                        width: 250,
                        child:
                            CustomProductScreenDrawer(outOfStock: outOfStock, products: products, onCategoryChanged: (String value) { setState(() { selectedCategory = value; }); },),
                      ),
                    Expanded(
                      child: BlocConsumer<DashboardCubit, DashboardState>(
                        listener: (context, state) async {
                          await Hive.box(AppConst.dashboardScreen)
                              .put('index', state.screenIndex);
                        },
                        builder: (context, state) {
                          return dashboardScreens[state.screenIndex];
                        },
                      ),
                    ),
                  ],
                ),
                floatingActionButton:
                    BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    return state.screenIndex != 0
                        ? const SizedBox()
                        : FloatingActionButton(
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              context.goNamed(AppRoute.addProduct,
                                  extra: {'isUpdate': false, 'product': null});
                            },
                            child: const Icon(Icons.add, color: Colors.white),
                          );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
