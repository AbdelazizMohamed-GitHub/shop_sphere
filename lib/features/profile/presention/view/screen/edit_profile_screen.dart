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
import 'package:shop_sphere/features/profile/data/repo_impl/user_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_state.dart';
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
  void dispose() {
    nameTextC.dispose();
    phoneTextC.dispose();
    super.dispose();
  }

  DateTime? selectedDate;
  String? selectGender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(userRepo: getIt<UserRepoImpl>()),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            Navigator.pop(context);
          }
          if (state is UserFailure) {
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
                    UserModel? userModel;
                    userModel!.copyWith(
                     
                      name: nameTextC.text,

                      phoneNumber: phoneTextC.text,
                      birthDate: selectedDate,
                      gender: selectGender,                    );

                    FocusScope.of(context).unfocus();
                    context.read<UserCubit>().updateUserData(userModel);
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
            body: state is UserLoading
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
                          CustomDropdown(text:widget.user.gender ?? 'Select Gender', 
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
