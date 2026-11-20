import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      home: Scaffold(
        body: TextButton(
          onPressed:()async {
           
      
          } ,
          child:const Center(
            child: Text('Test Screen'),
          ),
        ),
      ),
    );
  }

}