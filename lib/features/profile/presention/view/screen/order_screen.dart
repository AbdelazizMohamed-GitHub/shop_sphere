import 'package:flutter/material.dart';
import 'package:shop_sphere/core/test/test_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_stuts_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text('My Order'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child:  CustomOrderStutsList()
            )
          ],
        ),
      ),
    );
  }
}
