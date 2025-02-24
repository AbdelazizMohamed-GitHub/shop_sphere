import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomCategoryList extends StatefulWidget {
  const CustomCategoryList({super.key, });

  @override
  State<CustomCategoryList> createState() => _CustomCategoryListState();
}

class _CustomCategoryListState extends State<CustomCategoryList> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 12),
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
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color:
                  currentIndex == index ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Category $index',
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
