import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';

import 'package:skeletonizer/skeletonizer.dart';

class DetailsScreenLoading extends StatelessWidget {
  const DetailsScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Stack(children: [
                      Positioned(
                          top: 50,
                          left: 50,
                          right: 10,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: []),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, top: 20),
                    child: Text(
                      '  Perfumes vary in their compositions and longevity, ranging from highly concentrated perfumes (like "Parfum") to lighter fragrances (like "Eau de Cologne"). Each perfume is distinguished by its unique ingredients, which may be floral, woody, citrusy, or oriental, reflecting a distinctive character and personality for each wearer. 🌿✨',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
              )),
          bottomNavigationBar: Container(
            height: 60,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }
}
