import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressScreenLoading extends StatelessWidget {
  const AddressScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: AppColors.backgroundColor,
      body: Skeletonizer(
        enabled: true,
        child: ListView.separated(padding: const EdgeInsets.only(top: 20),
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Loading...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Loading...Loading...Loading...",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomCircleButton(
                          icon: const Icon(Icons.edit), funcation: () {}),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
