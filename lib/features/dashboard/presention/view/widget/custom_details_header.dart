import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class CustomDetailsHeader extends StatelessWidget {
  const CustomDetailsHeader({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            right: 10,
            bottom: 0,
            child: Image.network(product.imageUrl, fit: BoxFit.contain),
          ),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade400,
                      child: IconButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoute.addProduct,
                            extra: {
                              'isUpdate': true,
                              'product': product,
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(product.name, style: AppStyles.text22SemiBold),
                const SizedBox(height: 10),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppStyles.text18Regular,
                ),
              ],
            ),
          ),

          // const Positioned(
          //   bottom: 10,
          //   left: 0,
          //   right: 0,
          //   child: SizedBox(height: 100, child: CustomProductKind()),
          // )
        ],
      ),
    );
  }
}
