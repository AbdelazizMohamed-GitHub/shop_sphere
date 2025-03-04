import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_photo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leadingWidth: 100,
        leading:const CustomBackButton(),
        actions: [
          Text("Done",
              style: AppStyles.text18RegularBlack
                  .copyWith(color: AppColors.primaryColor)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            CustomAddPhoto(),
            SizedBox(
              height: 50,
            ),
            CustomTextForm(
                pIcon: Icons.person,
                text: "User Name",
                kType: TextInputType.text),
            SizedBox(
              height: 15,
            ),
            CustomTextForm(
                pIcon: Icons.phone,
                text: "Phone Number",
                kType: TextInputType.text),
            SizedBox(
              height: 15,
            ),
            CustomTextForm(
                pIcon: Icons.location_on,
                text: "Address",
                kType: TextInputType.text),
          ],
        ),
      ),
    );
  }
}
