import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_profile_list_tile.dart';

class CustomThemeWidget extends StatefulWidget {
  const CustomThemeWidget({super.key});

  @override
  State<CustomThemeWidget> createState() => _CustomThemeWidgetState();
}

class _CustomThemeWidgetState extends State<CustomThemeWidget> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return CustomProfileListTile(
      icon: Icons.dark_mode_outlined,
      title: 'Dark Mode',
      trailing: Switch(
          activeColor: Colors.white,
          value: active,
          onChanged: (val) {
           
            context.read<AppCubit>().toggleTheme();
            setState(() {
              active = val;
            });
          },
          inactiveTrackColor: Colors.white),
      funcation: () {},
    );
  }
}
