// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_data_birth.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_add_photo.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.user,
  });
  final UserEntity user;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameTextC = TextEditingController();
  TextEditingController phoneTextC = TextEditingController();
 

@override
  void initState() {
    nameTextC.text = widget.user.name;
    phoneTextC.text = widget.user.phoneNumber;
   
    super.initState();
}
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
      body: Padding(
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
             CustomTextForm(
              textController: nameTextC,
                pIcon: Icons.person,
                text: "User Name",
                kType: TextInputType.text),
            const SizedBox(
              height: 15,
            ),
             CustomTextForm(
              textController: phoneTextC,
                pIcon: Icons.phone,
                text: "Phone Number",
                kType: TextInputType.text),
            const SizedBox(
              height: 15,
            ),
           
         
            CustomAddBirthdate(onChanged: (DateTime date) {}, dataTime: widget.user.birthDate,),
          ],
        ),
      ),
    );
  }
}
