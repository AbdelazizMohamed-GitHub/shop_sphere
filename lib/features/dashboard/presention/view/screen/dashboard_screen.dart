import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/customer_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/order_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<OrderEntity> orders = [];
  List<OrderEntity> filteredOrders = [];
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(orderRepo: getIt<OrderRepoImpl>())
        ..getOrders(
          status: "all",
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Main Screen')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Dashboard', style: AppStyles.text26BoldWhite),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Orders'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const OrderScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory),
                title: const Text('Products'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ProductScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Customers'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CustomerScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Analytics'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AnalyticsScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search and Filter Row
              CustomTextForm(
                onChanged: (value) {
                  searchText = value;
                  setState(() {
                    filteredOrders = orders.where((e) {
                      return e.userName
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          e.orderId.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                    print(filteredOrders.length);
                  });
                },
                pIcon: Icons.search_rounded,
                text: "Search for order & customer",
                kType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      text: 'Select Category',
                      isUpdate: false,
                      categories: appCategory.map((e) => e.toString()).toList(),
                      onCategorySelected: (value) {
                        BlocProvider.of<OrderCubit>(context)
                            .getOrders(status: value);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomDropdown(
                      text: 'Select Status',
                      isUpdate: false,
                      categories: const ["Today", "Last 7 Days", "Last Mounth"],
                      onCategorySelected: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("orders")
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snap.hasError) {
                      return Center(
                        child: Text(snap.error.toString()),
                      );
                    } else if (snap.hasData) {
                      orders = snap.data!.docs
                          .map((e) => OrderModel.fromMap(e.data()))
                          .toList();

                      final displayOrders =
                          searchText.isEmpty ? orders : filteredOrders;

                      if (displayOrders.isEmpty) {
                        return const Center(
                          child: Text("No Orders Found"),
                        );
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Order ID')),
                              DataColumn(label: Text('Customer Name')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Total Amount')),
                            ],
                            rows: displayOrders
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(Text(
                                          '${e.orderId.substring(0, 9)}..')),
                                      DataCell(Text(e.userName)),
                                      DataCell(Text(DateFormat.yMMMEd()
                                          .format(e.orderDate))),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppFuncations.getStatusColor(
                                                e.status),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(e.status),
                                        ),
                                      ),
                                      DataCell(Text('\$${e.totalAmount}')),
                                    ],
                                  ),
                                  // Add more rows as needed
                                )
                                .toList(),
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
