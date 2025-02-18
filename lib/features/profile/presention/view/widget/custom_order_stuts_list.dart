import 'package:flutter/material.dart';
import 'package:shop_sphere/core/test/test_list.dart';

class CustomOrderStutsList extends StatelessWidget {
  const CustomOrderStutsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: TestList.orderStauts.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(TestList.orderStauts[index]),
                        )),
                  );
                },
              );
  }
}