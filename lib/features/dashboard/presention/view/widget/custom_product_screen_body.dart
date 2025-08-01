// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_product_gride.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomProductScreenBody extends StatefulWidget {
  const CustomProductScreenBody({
    super.key,
    required this.products,
    required this.onCategoryChanged,
  });
  final List<ProductEntity> products;
  final ValueChanged<String> onCategoryChanged;

  @override
  State<CustomProductScreenBody> createState() =>
      _CustomProductScreenBodyState();
}

class _CustomProductScreenBodyState extends State<CustomProductScreenBody> {
  @override
  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(children: [
                isDesktop
                    ? const SizedBox()
                    : Text(
                        "Welcome ",
                        style: AppStyles.text18Regular
                            .copyWith(color: AppColors.primaryColor),
                      ),
                // Text(
                //   '${FirebaseAuth.instance.currentUser!.displayName}',
                //   style: AppStyles.text18Regular,
                // ),
                const Spacer(),
                ResponsiveLayout.isDesktop(context)
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );
                        },
                        icon: const Icon(Icons.search, size: 30),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 16,
                ),
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
                  width: 16,
                )
              ]),
            ),
            CustomProductGrid(products: widget.products)
          ],
        ),
      ),
    );
  }
}
