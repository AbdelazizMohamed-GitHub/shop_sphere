import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Explore',
          style: AppStyles.text26BoldBlack,
        ),
        actions: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart, size: 25),
              ),
              const Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 8,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextForm(
                        pIcon: Icons.search,
                        text: 'Looking for something?',
                        kType: TextInputType.text),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(AppImages.filter, width: 30, height: 30),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: AppStyles.text18RegularBlack,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
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
              ),
            ),
            SizedBox(height: 10),
            CarouselSlider(
                items: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(AppImages.product, fit: BoxFit.fill),
                      ),
                      Positioned(
                        width: 120,
                        right: 40,
                        bottom: 40,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'offer 50%',
                            style: AppStyles.text22SemBoldWhite,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  const Text(
                    'New Arrivels',
                    style: AppStyles.text22SemiBoldBlack,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: AppStyles.text18RegularBlack,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ).copyWith(),
                    child:
                        const SizedBox(width: 150, child: CustomProductItem()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  const Text(
                    'Populer',
                    style: AppStyles.text18RegularBlack,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: AppStyles.text18RegularBlack,
                      ))
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CustomProductItem();
              },
            )
          ],
        ),
      ),
    );
  }
}
