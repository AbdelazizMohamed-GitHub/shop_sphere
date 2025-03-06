import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/screens_list.dart';
import 'package:shop_sphere/features/main/presention/view/controller/main_cubit/main_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: context.read<MainCubit>().intialIndex,
              onTap: (index) {
                context.read<MainCubit>().changeScreenIndex(index);
              },
              selectedItemColor: AppColors.primaryColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            body: IndexedStack(
              index: context.read<MainCubit>().intialIndex,
              children: screens,
            ),
          );
        },
      ),
    );
  }
}
