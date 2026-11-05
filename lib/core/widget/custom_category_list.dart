import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/theme/app_theme.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/dashboard/presention/controller/product_cubit/dashboard_cubit.dart';

class CustomCategoryList extends StatefulWidget {
  const CustomCategoryList({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;

  @override
  State<CustomCategoryList> createState() => _CustomCategoryListState();
}

class _CustomCategoryListState extends State<CustomCategoryList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(right: 12),
      scrollDirection: Axis.horizontal,
      itemCount: appCategory.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context
                  .read<DashboardCubit>()
                  .getProducts(category: appCategory[index]);
            });
            setState(() {
              currentIndex = index;
            });
            widget.onTap();
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.primaryColor
                  : AppTheme.isLightTheme(context)
                      ? Colors.white
                      : AppColors.secondaryDarkColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                appCategory[index],
                style: AppStyles.text16Bold.copyWith(
                    color: currentIndex == index
                        ? Colors.white
                        : AppTheme.isLightTheme(context)
                            ? Colors.black
                            : Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
