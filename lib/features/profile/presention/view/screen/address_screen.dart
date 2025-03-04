import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Funcations.addNewAddress(context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      appBar: AppBar(
        title: const Text('Address'),
        leadingWidth: 100,
        leading: const CustomBackButton(),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text(
                "My Home",
                style: AppStyles.text16BoldBlack,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Funcations.addNewAddress(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                  ))
            ]),
            const Text(
              "+20 1234567890",
              style: AppStyles.text16RegularBlack,
            ),
            const Text(
              "3 El Nozha Street, Cairo, Egypt",
              style: AppStyles.text16RegularBlack,
            ),
          ],
        ),
      ),
    );
  }
}
