import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/screens_list.dart';

class CustomCategoryList extends StatefulWidget {
  const CustomCategoryList({
    super.key,
  });

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
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color:
                  currentIndex == index ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                category[index],
                style: AppStyles.text16BoldBlack.copyWith(
                    color: currentIndex == index ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
