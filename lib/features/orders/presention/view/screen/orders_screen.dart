
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/orders/presention/view/widget/custom_orders_filters.dart';
import 'package:shop_sphere/features/orders/presention/view/widget/custom_orders_header.dart';
import 'package:shop_sphere/features/orders/presention/view/widget/custom_orders_table.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/order_repo_impl.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, required this.onMenuPressed});
  final VoidCallback onMenuPressed;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _searchQuery = '';
  String _selectedStatus = 'All';
  String _selectedPrice = 'All';

  List<OrderEntity> _filterOrders(List<OrderEntity> orders) {
    return orders.where((order) {
      // Search filter
      final matchesSearch =
          _searchQuery.isEmpty ||
          order.userName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          order.address.state.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          order.trackingNumber.toString().contains(_searchQuery);

      // Status filter
      final matchesStatus =
          _selectedStatus == 'All' ||
          order.status == _selectedStatus;

      // Price filter
      final amount = order.totalAmount;

      final matchesPrice = switch (_selectedPrice) {
        '0-100' => amount < 100,
        '100-1000' => amount >= 100 && amount < 1000,
        '1000-more' => amount >= 1000,
        _ => true,
      };

      return matchesSearch && matchesStatus && matchesPrice;
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.trim();
    });
  }

  void _onStatusChanged(String value) {
    setState(() {
      _selectedStatus = value;
    });
  }

  void _onPriceChanged(String value) {
    setState(() {
      _selectedPrice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final horizontalPadding =
        ResponsiveLayout.getHorizontalPadding(context);

    return BlocProvider(
      create: (context) =>
          OrderCubit(orderRepo: getIt<OrderRepoImpl>())
            ..getOrderLength(),
      child: Scaffold(
        appBar: !isDesktop
            ? AppBar(leading: IconButton(
            onPressed: widget.onMenuPressed,
            icon: const Icon(Icons.menu),
          ),
                title: const Text('Orders'),
              )
            : null,

        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .orderBy('orderDate', descending: true)
              .snapshots(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong: ${snapshot.error}',
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Orders Found'),
              );
            }

            final orders = snapshot.data!.docs
                .map(
                  (doc) => OrderModel.fromMap(doc.data()),
                )
                .toList();

            final filteredOrders = _filterOrders(orders);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search and count
                  CustomOrdersHeader(
                    onSearchChanged: _onSearchChanged,
                    filteredCount: filteredOrders.length,
                    isSearching: _searchQuery.isNotEmpty,
                  ),

                  const SizedBox(height: 16),

                  // Filters
                  CustomOrdersFilters(
                    selectedStatus: _selectedStatus,
                    selectedPrice: _selectedPrice,
                    onStatusChanged: _onStatusChanged,
                    onPriceChanged: _onPriceChanged,
                  ),

                  const SizedBox(height: 20),

                  // Orders table
                  CustomOrdersTable(
                    orders: filteredOrders,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
