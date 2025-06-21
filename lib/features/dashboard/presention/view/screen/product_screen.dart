import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/order_analysis_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/users_screen.dart';
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
            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child:
                          Text('Dashboard', style: AppStyles.text26BoldWhite),
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: const Text('Orders'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const OrdersScreen();
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Users'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const UsersScreen();
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics_outlined),
                      title: const Text('out of stock'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OutOfStockScreen(
                                products: outOfStock,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign Out'),
                      onTap: () async {
                        await GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(children: [
                        Text(
                          "Welcome ",
                          style: AppStyles.text18Regular
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        Text(
                          '${FirebaseAuth.instance.currentUser!.displayName}',
                          style: AppStyles.text18Regular,
                        ),
                        const Spacer(),
                        PopupMenuButton(
                            child: const Icon(Icons.filter_list),
                            itemBuilder: (context) =>
                                appCategory.map((category) {
                                  return PopupMenuItem(
                                    onTap: () {
                                      selectedCategory = category;
                                      setState(() {});
                                    },
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList()),
                        const SizedBox(
                          width: 10,
                        )
                      ]),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 5 / 6,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomDashboardProductItem(
                            product: products[index]);
                      },
                    ),
                  ],
                ),
              ),
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
          }
        });
  }
}
