import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage, this.onpressed});
final String errorMessage;
final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:  [
          Center(child: Text(errorMessage)),
          const SizedBox(height: 10),
          TextButton(onPressed:onpressed , child:const Text('Retry') )
        
        ],
      ),
    );
  }
}