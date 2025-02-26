import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';

class CustomDetailsButtom extends StatefulWidget {
  const CustomDetailsButtom({super.key});

  @override
  State<CustomDetailsButtom> createState() => _CustomDetailsButtomState();
}

class _CustomDetailsButtomState extends State<CustomDetailsButtom> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (count == 0) return;
                        setState(() {
                          count--;
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        size: 30,
                      )),
                  Text(
                    count.toString(),
                    style: AppStyles.text26BoldBlack,
                  ),
                  IconButton(
                      onPressed: () {
                        if (count == 10) return;
                        setState(() {
                          count++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      )),
                ],
              )),
          const SizedBox(
            width: 10,
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
    );
  }
}
