// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/data/model/user_model.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_state.dart';
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

  DateTime? selectedDate;
  String? selectGender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepo: getIt<ProfileRepoImpl>()),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
           
            Navigator.pop(context);
          }
          if (state is EditProfileFirebaseFailure) {
            Warning.showWarning(context, message: state.errMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Profile"),
              leadingWidth: 100,
              leading: const CustomBackButton(),
              actions: [
                TextButton(
                  onPressed: () async {
                    UserModel userModel = UserModel(
                      name: nameTextC.text,
                      phoneNumber: phoneTextC.text,
                      birthDate: selectedDate ?? widget.user.birthDate,
                      email: widget.user.email,
                      gender: selectGender ?? widget.user.gender,
                      addressIndex: widget.user.addressIndex,
                      uid: widget.user.uid,
                      profileImage: widget.user.profileImage,
                      createdAt: widget.user.createdAt,
                    );
                    FocusScope.of(context).unfocus();
                    context.read<ProfileCubit>().updateUserData(userModel);
                     await BlocProvider.of<ProfileCubit>(context).getUserData();
                  },
                  child: Text("Save",
                      style: AppStyles.text18Regular.copyWith(
                        color: AppColors.primaryColor,
                      )),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            body: state is EditProfileLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
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
                          CustomAddBirthdate(
                            onChanged: (DateTime date) {
                              selectedDate = date;
                            },
                            dataTime: widget.user.birthDate,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomDropdown(
                              categories: const ['Male', 'Female'],
                              onCategorySelected: (valu) {
                                selectGender = valu;
                              }),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
