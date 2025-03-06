import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/app_cubit/app_state.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';
import 'package:shop_sphere/features/onboarding/presention/view/screen/get_started_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/checkout_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/order_done_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/profile_screen.dart';

import 'package:shop_sphere/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ShopSphere());
}

class ShopSphere extends StatelessWidget {
  const ShopSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopSphere',
            theme: state is AppChangeThemeDark
                ? AppTheme.darkTheme
                : state is AppChangeThemeLight?AppTheme.lightTheme:AppTheme.darkTheme,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
