import 'package:flutter/material.dart';

class CustomCategoryList extends StatelessWidget {
  const CustomCategoryList({super.key});

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
                  return Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Category $index'),
                    ),
                  );
                },
              );
  }
}