import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/cart_screen.dart';

class CustomAppBarCart extends StatelessWidget {
  const CustomAppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        CustomCircleButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            funcation: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
            }),
        const Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 8,
              child: Text(
                '0', // This should be replaced with the actual cart item count
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              )),
        ),
      ],
    );
  }
}
