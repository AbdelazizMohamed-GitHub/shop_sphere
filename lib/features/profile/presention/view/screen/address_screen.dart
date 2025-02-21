import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        leadingWidth: 100,
        leading:const CustomBackButton(),
      ),
      body: const Center(child: Text('Address Screen')),
    );
  }
}