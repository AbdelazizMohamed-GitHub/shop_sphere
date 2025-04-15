import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
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
                onTap: () {
                 FirebaseAuth.instance.signOut();
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
              const CustomTextForm(
                pIcon: Icons.search_rounded,
                text: "Search about order",
                kType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      isUpdate: false,
                      categories: appCategory.map((e) => e.toString()).toList(),
                      onCategorySelected: (value) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomDropdown(
                      isUpdate: false,
                      categories: const ["Today", "Last 7 Days", "Last Mounth"],
                      onCategorySelected: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  List<OrderEntity> orders = [];
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is OrderError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: AppStyles.text16Bold.copyWith(color: Colors.red),
                      ),
                    );
                  }
                  if (state is OrderSuccess) {
                    orders = state.orders;
                  }

                  return orders.isEmpty
                      ? Center(
                          child: Text(
                            'Total Orders: ${orders.length}',
                            style: AppStyles.text26BoldBlack,
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Order ID')),
                              DataColumn(label: Text('Customer Name')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Total Amount')),
                            ],
                            rows: orders
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(Text(
                                          '${e.orderId.substring(0, 5)}...')),
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
                                            color: Colors.yellow[100],
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
