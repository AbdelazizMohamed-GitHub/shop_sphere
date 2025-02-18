import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leadingWidth: 100,
        leading: CustomCircleButton(
            icon: const Icon(Icons.arrow_back_ios),
            funcation: () {
              Navigator.pop(context);
            }),
        actions: [
          Text("Done",
              style: AppStyles.text18RegularBlack
                  .copyWith(color: AppColors.primaryColor)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(AppImages.profile),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
