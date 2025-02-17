import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_product_item.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_new_arrivels_list.dart';
import 'package:shop_sphere/features/explor/presention/view/widget/custom_product_title_section.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(children: [
                  Positioned(
                      top: 10,
                      left: 50,
                      right: -30,
                      bottom: 0,
                      child: Image.asset(AppImages.product)),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Product Name",
                            style: AppStyles.text18RegularBlack.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Price",
                            style: AppStyles.text18RegularBlack.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ]),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
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
                              child: Text('Kind $index',
                                  style: AppStyles.text22SemiBoldBlack),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, top: 20),
                child: ReadMoreText(
                  'Perfume is a blend of essential oils, aromatic compounds, and solvents, used to give the body, clothes, or environment a pleasant and attractive scent. Perfumes vary in their compositions and longevity, ranging from highly concentrated perfumes (like "Parfum") to lighter fragrances (like "Eau de Cologne"). Each perfume is distinguished by its unique ingredients, which may be floral, woody, citrusy, or oriental, reflecting a distinctive character and personality for each wearer. 🌿✨',
                  style: TextStyle(fontSize: 16),
                  trimMode: TrimMode.Length,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ),
              const CustomProductTitleSection(title: 'Related Products'),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 200, child: CustomNewArrivelsList())
            ]),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        )),
                    const Text(
                      '1',
                      style: AppStyles.text26BoldBlack,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ],
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add to cart',
                      style: AppStyles.text26BoldWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
