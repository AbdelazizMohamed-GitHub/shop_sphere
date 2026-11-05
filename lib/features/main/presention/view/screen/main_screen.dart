import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/internet.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/main/presention/controller/main_cubit/main_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget?> _loadedTabs = List<Widget?>.filled(screens.length, null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final mainCubit = context.read<MainCubit>();
          _loadedTabs[mainCubit.intialIndex] ??= screens[mainCubit.intialIndex];
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              mainCubit.changeScreenIndex(0);
            },
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: mainCubit.intialIndex,
                onTap: (index) {
                  mainCubit.changeScreenIndex(index);
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
              body: InternetBannerWrapper(
                child: IndexedStack(
                  index: mainCubit.intialIndex,
                  children: _loadedTabs
                      .map((screen) => screen ?? const SizedBox.shrink())
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
