import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/service/internet.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    BlocProvider.of<OrderCubit>(context).getOrderLength();

    super.initState();
  }

  List<OrderEntity> orders = [];
  List<OrderEntity> filteredOrders = [];
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return state is GetOrderLoading
                  ? const Skeletonizer(enabled: true, child: Text("Loading"))
                  : Text(
                      "${searchText.isEmpty ? context.read<OrderCubit>().currentOrderLength : filteredOrders.length} Orders",
                      style: AppStyles.text22SemiBold,
                    );
            },
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: InternetBannerWrapper(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
              CustomTextForm(
                onChanged: (value) {
                  searchText = value;
                  setState(() {
                    filteredOrders = orders.where((e) {
                      return e.userName
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          e.items.any((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase())) ||
                          e.address.state
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          e.trackingNumber
                              .toString()
                              .contains(value.toLowerCase());
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
                    flex: 3,
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
                      flex: 2,
                      child: CustomDropdown(
                          categories: const [
                            "All",
                            "0-100",
                            "100-1000",
                            "1000-more"
                          ],
                          onCategorySelected: (value) {
                            if (value == "0-100") {
                              filteredOrders = orders
                                  .where((e) => e.totalAmount < 100)
                                  .toList();
                              searchText = value;
                            }
                            if (value == "100-1000") {
                              filteredOrders = orders
                                  .where((e) =>
                                      e.totalAmount >= 100 &&
                                      e.totalAmount < 1000)
                                  .toList();
                              searchText = value;
                            }
                            if (value == "1000-more") {
                              filteredOrders = orders
                                  .where((e) => e.totalAmount >= 1000)
                                  .toList();
                              searchText = value;
                            }
                            setState(() {});
                          },
                          isUpdate: false,
                          text: "Select Price")),
                ],
              ),
              const SizedBox(height: 20),
        
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("orders")
                    .orderBy("orderDate", descending: true)
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
                            DataColumn(label: Text('Number')),
                            DataColumn(label: Text('Tracking Number')),
                            DataColumn(label: Text('Customer Name')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Payment Method')),
                            DataColumn(label: Text('Total Amount')),
                            DataColumn(label: Text('Actions')),
                            DataColumn(label: Text('Details')),
                          ],
                          rows: displayOrders.asMap().entries.map(
                            (entry) {
                              final index =
                                  entry.key + 1; // علشان تبدأ من 1 مش من 0
                              final order = entry.value;
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                      index.toString())), // 👈 هنا الرقم التسلسلي
                                  DataCell(Text(order.trackingNumber.toString())),
                                  DataCell(Text(order.userName)),
                                  DataCell(Text(DateFormat.yMMMEd()
                                      .format(order.orderDate))),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppFuncations.getStatusColor(
                                            order.status),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(order.status),
                                    ),
                                  ),
                                  DataCell(Text(order.paymentMethod)),
                                  DataCell(Text('${order.totalAmount} EGP')),
                                  DataCell(
                                    order.status == 'Pending'
                                        ? TextButton(
                                            onPressed: () async {
                                              await BlocProvider.of<OrderCubit>(
                                                      context)
                                                  .getTrackinNumber();
                                              await context
                                                  .read<OrderCubit>()
                                                  .changeOrdeStatus(
                                                    status: orderStauts[2],
                                                    orderId: order.orderId,
                                                    trackingNumber: context
                                                        .read<OrderCubit>()
                                                        .currentTrackingNumber,
                                                  );
                                            },
                                            child: const Text('Process'),
                                          )
                                        : order.status == 'Processing'
                                            ? TextButton(
                                                onPressed: () async {
                                                  await context
                                                      .read<OrderCubit>()
                                                      .changeOrdeStatus(
                                                          status: orderStauts[3],
                                                          orderId: order.orderId,
                                                          trackingNumber: order
                                                              .trackingNumber);
                                                },
                                                child: const Text('Complete'),
                                              )
                                            : const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
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
                              );
                            },
                          ).toList(),
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
      ),
    );
  }
}
