import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
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
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon:const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                )),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.isLightTheme(context)
              ? Colors.white
              : AppColors.secondaryDarkColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text(
                "My Home",
                style: AppStyles.text16Bold,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Funcations.addNewAddress(context);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppTheme.isLightTheme(context)
                        ? Colors.black
                        : Colors.white,
                  ))
            ]),
            const Text(
              "+20 1234567890",
              style: AppStyles.text16Regular,
            ),
            const Text(
              "3 El Nozha Street, Cairo, Egypt",
              style: AppStyles.text16Regular,
            ),
          ],
        ),
      ),
    );
  }
}
