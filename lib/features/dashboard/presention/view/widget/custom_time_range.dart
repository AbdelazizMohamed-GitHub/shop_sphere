import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/utils/app_color.dart';
import 'package:shop_sphere_dashboard/core/utils/app_styles.dart';
import 'package:shop_sphere_dashboard/core/utils/screens_list.dart';

class CustomTimeRange extends StatefulWidget {
  const CustomTimeRange({super.key});

  @override
  State<CustomTimeRange> createState() => _CustomTimeRangeState();
}

class _CustomTimeRangeState extends State<CustomTimeRange> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: timeRange.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 10);
      },
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  selectedIndex == index
                      ? AppColors.primaryColor
                      : Colors.white,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.0),

            child: Text(
              "${timeRange[index]}",
              style:
                  selectedIndex == index
                      ? AppStyles.text16Regular.copyWith(color: Colors.white)
                      : AppStyles.text16Regular,
            ),
          ),
        );
      },
    );
  }
}
