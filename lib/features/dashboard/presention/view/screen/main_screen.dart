import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/customer_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/order_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    categories: const [
                      "All",
                      "Pending",
                      "Process",
                      "Delivared",
                      "Cancel",
                    ],
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

            // Create New Order Button

            // Orders Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Order ID')),
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Total Amount')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text('#12345')),
                      const DataCell(Text('John Doe')),
                      const DataCell(Text('2023-10-15')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Pending'),
                        ),
                      ),
                      const DataCell(Text('\$150.00')),
                    ],
                  ),
                  // Add more rows as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
