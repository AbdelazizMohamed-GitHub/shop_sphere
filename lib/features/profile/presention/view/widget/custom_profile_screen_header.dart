import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/app_cubit/app_cubit.dart';
import 'package:shop_sphere/core/app_cubit/app_state.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/profile_state.dart';

class CustomProfileScreenHeader extends StatelessWidget {
  const CustomProfileScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state is GetUserDataSucess
            ? Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.user.name ?? "",
                    style: AppStyles.text18RegularWhite,
                  ),
                  Text(
                    state.user.email ?? "",
                    style: AppStyles.text18RegularWhite,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            : state is GetUserDataFailure
                ? Text(state.errMessage)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
      },
    );
  }
}
