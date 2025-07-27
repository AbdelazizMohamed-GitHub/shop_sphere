// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/order_analysis_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/out_of_stock_screen.dart';
import 'package:shop_sphere/features/users/presention/view/screen/users_screen.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/shopsphere_app.dart';

class CustomProductScreenDrawer extends StatelessWidget {
  const CustomProductScreenDrawer({
    super.key,
    required this.outOfStock,
  });
final List<ProductEntity> outOfStock;
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          try {
                            if (!await AppFuncations.isOnline()) {
                              Warning.showWarning(context,
                                  isError: true,
                                  message: "No internet connection");
                              return;
                            }
                            await GoogleSignIn().signOut();
                            await FirebaseAuth.instance.signOut();
                            // Clear user data from Firestore if needed
                            await Future.delayed(const Duration(seconds: 5));
                            // Navigate to the login screen or home screen
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const ShopSphere()),
                              (route) => false,
                            );
                          } catch (e) {
                            Warning.showWarning(context,
                                isError: true, message: '${e.toString()}');
                          }
                        },
                      ),
                    ],
                  ),
                );
  }
}
