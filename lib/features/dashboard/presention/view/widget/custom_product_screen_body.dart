// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_dashboard_product_item.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomProductScreenBody extends StatefulWidget {
  const CustomProductScreenBody({
    super.key,
    required this.products,
    required this.horizontalPadding,
    required this.crossAxisCount,
    required this.onCategoryChanged,
  });
  final List<ProductEntity> products;
  final ValueChanged<String> onCategoryChanged;
  final double horizontalPadding;
  final int crossAxisCount;

  @override
  State<CustomProductScreenBody> createState() =>
      _CustomProductScreenBodyState();
}

class _CustomProductScreenBodyState extends State<CustomProductScreenBody> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(children: [
              Text(
                "Welcome ",
                style: AppStyles.text18Regular
                    .copyWith(color: AppColors.primaryColor),
              ),
              // Text(
              //   '${FirebaseAuth.instance.currentUser!.displayName}',
              //   style: AppStyles.text18Regular,
              // ),
              // const Spacer(),
              PopupMenuButton(
                  child: const Icon(Icons.filter_list),
                  itemBuilder: (context) => appCategory.map((category) {
                        return PopupMenuItem(
                          onTap: () {
                            widget.onCategoryChanged(category);
                            setState(() {});
                          },
                          value: category,
                          child: Text(category),
                        );
                      }).toList()),
              const SizedBox(
                width: 10,
              )
            ]),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 5 / 6,
            ),
            itemCount: widget.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomDashboardProductItem(
                  product: widget.products[index]);
            },
          ),
        ],
      ),
    );
  }
}
