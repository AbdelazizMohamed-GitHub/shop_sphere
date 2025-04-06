import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomItemLoading extends StatelessWidget {
  const CustomItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
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
                        const Text("Loading...Loading...",
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
              ),
    );
  }
}