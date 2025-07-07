import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_data.dart';

class CustomTimeRange extends StatelessWidget {
  const CustomTimeRange({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: timeRange.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 10);
      },
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
           
          
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:index == 1
                  ? AppColors.primaryColor
                  : Colors.white,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "${timeRange[index]}",
              style: 1 == index
                  ? AppStyles.text16Regular.copyWith(color: Colors.white)
                  : AppStyles.text16Regular,
            ),
          ),
        );
      },
    );
  }
}
