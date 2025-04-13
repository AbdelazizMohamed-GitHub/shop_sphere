import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Users')),
            DataColumn(label: Text('Revenue')),
            DataColumn(label: Text('Conversion')),
            DataColumn(label: Text('Avg. Session')),
          ],
          rows: [
            _buildDataRow('2023-06-01', '1,234', '\$2,345', '3.2%', '2m 45s'),
            _buildDataRow('2023-06-02', '1,567', '\$3,210', '3.8%', '3m 12s'),
            _buildDataRow('2023-06-03', '1,890', '\$4,100', '4.1%', '3m 30s'),
            _buildDataRow('2023-06-04', '2,100', '\$4,500', '4.3%', '3m 45s'),
            _buildDataRow('2023-06-05', '1,750', '\$3,800', '4.0%', '3m 20s'),
          ],
        ),
      ),
    );
  }
    DataRow _buildDataRow(String date, String users, String revenue, String conversion, String avgSession) {
    return DataRow(
      cells: [
        DataCell(Text(date)),
        DataCell(Text(users)),
        DataCell(Text(revenue)),
        DataCell(Text(conversion)),
        DataCell(Text(avgSession)),
      ],
    );
  }

}