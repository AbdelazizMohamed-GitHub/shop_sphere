// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomProductScreenDrawer extends StatelessWidget {
  const CustomProductScreenDrawer({
    super.key,
    required this.outOfStock,
  });
  final List<ProductEntity> outOfStock;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Dashboard', style: AppStyles.text26BoldWhite),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dashboardDrawerItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Icon(dashboardDrawerItems[index].icon),
                  title: Text(
                    dashboardDrawerItems[index].title,
                    style: AppStyles.text18Regular,
                  ),
                  onTap: () {
                    context.read<DashboardCubit>().changeScreenIndex(index);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         dashboardDrawerItems[index].screen,
                    //   ),
                    // );
                  });
            },
          ),
        ],
      ),
    );
  }
}
