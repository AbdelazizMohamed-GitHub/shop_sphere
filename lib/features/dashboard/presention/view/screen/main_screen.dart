import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/utils/app_styles.dart';
import 'package:shop_sphere_dashboard/core/widget/custom_text_form.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/analytics_screen.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/customer_screen.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/order_screen.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/product_screen.dart';
import 'package:shop_sphere_dashboard/features/presention/view/widget/custom_dropdown_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Dashboard', style: AppStyles.text26BoldWhite),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OrderScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Customers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CustomerScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Analytics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AnalyticsScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search and Filter Row
            CustomTextForm(
              pIcon: Icons.search_rounded,
              text: "Search about order",
              kType: TextInputType.text,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    isUpdate: false,
                    categories: [
                      "All",
                      "Pending",
                      "Process",
                      "Delivared",
                      "Cancel",
                    ],
                    onCategorySelected: (value) {},
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomDropdown(
                    isUpdate: false,
                    categories: ["Today", "Last 7 Days", "Last Mounth"],
                    onCategorySelected: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Create New Order Button

            // Orders Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Order ID')),
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Total Amount')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('#12345')),
                      DataCell(Text('John Doe')),
                      DataCell(Text('2023-10-15')),
                      DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Pending'),
                        ),
                      ),
                      DataCell(Text('\$150.00')),
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
