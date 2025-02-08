import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   bottomNavigationBar: BottomNavigationBar(
     items: const [
       BottomNavigationBarItem(
         icon: Icon(Icons.home),
         label: 'Home',
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.favorite),
         label: 'Favorites',
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.notifications_outlined),
         label: 'Notifications',
       ),  BottomNavigationBarItem(
         icon: Icon(Icons.person),
         label: 'Profile',
       ),
     ],
   ),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }
}