import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/service/internet.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_body.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_screen_drawer.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedCategory = "All";
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
            ));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Scaffold(
                body: Center(child: Text("No Products Found")));
          } else {
            final List<ProductEntity> products = snapshot.data!.docs
                .map((doc) => ProductModel.fromMap(doc.data()))
                .toList();
            if (selectedCategory != "All") {
              products.retainWhere((product) =>
                  product.category.toLowerCase() ==
                  selectedCategory.toLowerCase());
            }

            List<ProductEntity> outOfStock =
                products.where((product) => product.stock == 0).toList();
            return LayoutBuilder(builder: (context, constraints) {
              double horizontalPadding =
                  MediaQuery.of(context).size.width > 600 ? 20 : 10;
              int crossAxisCount = 2;
              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 5;
              } else if (constraints.maxWidth >= 900) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 3;
              }
              if (MediaQuery.of(context).size.width > 900) {
                return Scaffold(
                  body: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: CustomProductScreenDrawer(
                          outOfStock: outOfStock,
                        ),
                      ),
                      Expanded(
                          child: CustomProductScreenBody(
                        products: products,
                        horizontalPadding: horizontalPadding,
                        crossAxisCount: crossAxisCount,
                        onCategoryChanged: (String value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ))
                    ],
                  ),
                );
              }

              return Scaffold(
                drawer: CustomProductScreenDrawer(
                  outOfStock: outOfStock,
                ),
                appBar: AppBar(
                  title: Text("Products ${products.length}",
                      style: AppStyles.text18Regular),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()),
                        );
                      },
                      icon: const Icon(Icons.search, size: 30),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                body: InternetBannerWrapper(
                    child: CustomProductScreenBody(
                  products: products,
                  horizontalPadding: horizontalPadding,
                  crossAxisCount: crossAxisCount,
                  onCategoryChanged: (String value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                )),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddProductScreen(isUpdate: false),
                      ),
                    );
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            });
          }
        });
  }
}
