import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';

class OrderAnalycisScreen extends StatefulWidget {
  const OrderAnalycisScreen({super.key});

  @override
  State<OrderAnalycisScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<OrderAnalycisScreen> {
  List<OrderEntity> orders = [];
  List<OrderEntity> filteredOrders = [];
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
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
                });
              },
              pIcon: Icons.search_rounded,
              text: "Search for order & customer",
              kType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomDropdown(
                    text: 'Select Status',
                    isUpdate: false,
                    categories: orderStauts.map((e) => e.toString()).toList(),
                    onCategorySelected: (value) {
                      if (value == "All") {
                        searchText = '';
                      } else {
                        filteredOrders =
                            orders.where((e) => e.status == value).toList();
                        searchText = value;
                      }
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                    flex: 1,
                    child: Text(
                      "${searchText.isEmpty ? orders.length : filteredOrders.length} Orders",
                      style: AppStyles.text22SemiBold,
                    )),
              ],
            ),
            const SizedBox(height: 20),
    
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("orders").snapshots(),
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
                                  DataCell(
                                      Text('${e.orderId.substring(0, 9)}..')),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
