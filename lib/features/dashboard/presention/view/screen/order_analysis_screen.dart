import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_details_screen.dart';

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
                          DataColumn(label: Text('Tracking Number')),
                          DataColumn(label: Text('Customer Name')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Payment Method')),
                          DataColumn(label: Text('Total Amount')),
                          DataColumn(label: Text('Actions')),
                          DataColumn(label: Text('Details')),
                        ],
                        rows: displayOrders
                            .map(
                              (order) => DataRow(
                                cells: [
                                  DataCell(
                                      Text(order.trackingNumber.toString())),
                                  DataCell(Text(order.userName)),
                                  DataCell(Text(DateFormat.yMMMEd()
                                      .format(order.orderDate)
                                      .toString())),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppFuncations.getStatusColor(
                                            order.status),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(order.status),
                                    ),
                                  ),
                                  DataCell(Text(order.paymentMethod)),
                                  DataCell(Text('\$${order.totalAmount}')),
                                  DataCell(
                                    TextButton(
                                      onPressed: () {
                                        // Handle view details button press
                                      },
                                      child: const Text('Process'),
                                    ),
                                  ),
                                  DataCell(
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrdersDetailsScreen(order: order),
                                          ),
                                        );
                                      },
                                      child: const Text('View Details'),
                                    ),
                                  ),
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
