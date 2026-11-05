
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/features/orders/presention/view/widget/ustom_order_status_action.dart';
import 'package:shop_sphere/features/profile/domain/entity/order_entity.dart';


class CustomOrdersTable extends StatelessWidget {
  final List<OrderEntity> orders;

  const CustomOrdersTable({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No Orders Found'),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 12,
        columns: const [
          DataColumn(label: Text('Num')),
          DataColumn(label: Text('Tracking Num')),
          DataColumn(label: Text('Customer Name')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Payment Method')),
          DataColumn(label: Text('Total Cost')),
          DataColumn(label: Text('Actions')),
          DataColumn(label: Text('Details')),
        ],
        rows: orders.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final order = entry.value;

          return DataRow(
            cells: [
              DataCell(Text(index.toString())),

              DataCell(
                Text(order.trackingNumber.toString()),
              ),

              DataCell(
                Text(order.userName),
              ),

              DataCell(
                Text(
                  DateFormat.yMMMEd().format(order.orderDate),
                ),
              ),

              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppFuncations.getStatusColor(
                      order.status,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(order.status),
                ),
              ),

              DataCell(
                Text(order.paymentMethod),
              ),

              DataCell(
                Text('${order.totalAmount} EGP'),
              ),

              DataCell(
                CustomOrderStatusAction(
                  order: order,
                ),
              ),

              DataCell(
                TextButton(
                  onPressed: () {
                    context.pushNamed(
                      'orderDetails',
                      pathParameters: {
                        'orderId': order.orderId,
                      },
                      extra: order,
                    );
                  },
                  child: const Text('View Details'),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
