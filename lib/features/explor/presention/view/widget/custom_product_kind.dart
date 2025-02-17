import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';

class CustomProductKind extends StatelessWidget {
  const CustomProductKind({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(AppImages.product),
                  ),
                );
              },
            );
  }
}