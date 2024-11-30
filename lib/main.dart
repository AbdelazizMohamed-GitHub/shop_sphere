import 'package:flutter/material.dart';

void main() {
  const ShopSphere();
}

class ShopSphere extends StatelessWidget {
  const ShopSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const Scaffold(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
