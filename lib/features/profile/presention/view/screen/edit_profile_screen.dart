import 'package:flutter/material.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_data_birth.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_photo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leadingWidth: 100,
        leading: const CustomBackButton(),
        actions: [
          Text("Done",
              style: AppStyles.text18Regular
                  .copyWith(color: AppColors.primaryColor)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const CustomAddPhoto(),
            const SizedBox(
              height: 50,
            ),
            const CustomTextForm(
                pIcon: Icons.person,
                text: "User Name",
                kType: TextInputType.text),
            const SizedBox(
              height: 15,
            ),
            const CustomTextForm(
                pIcon: Icons.phone,
                text: "Phone Number",
                kType: TextInputType.text),
            const SizedBox(
              height: 15,
            ),
            const CustomTextForm(
                pIcon: Icons.location_on,
                text: "Address",
                kType: TextInputType.text),
            const SizedBox( height: 15,),
            CustomAddBirthdate(onChanged: (DateTime date) {
             
            }),
          ],
        ),
      ),
    );
  }
}
