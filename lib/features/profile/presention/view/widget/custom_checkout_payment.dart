import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/screens_list.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_checkout_listile.dart';

class CustomCheckoutPayment extends StatefulWidget {
  const CustomCheckoutPayment({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<int> onChanged;

  @override
  State<CustomCheckoutPayment> createState() => _CustomCheckoutPaymentState();
}

class _CustomCheckoutPaymentState extends State<CustomCheckoutPayment> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: paymentMethod.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onChanged(index);
            setState(() {
              currentIndex = index;
            });
          },
          child: CustomCheckoutListile(
              isSelect: currentIndex == index,
              title: paymentMethod[index].title,
              subtitle: paymentMethod[index].title,
              icon: Image.asset(
                paymentMethod[index].imagePath,
                fit: BoxFit.cover,
              )),
        );
      },
    );
  }
}
