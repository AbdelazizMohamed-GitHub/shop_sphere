import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

class CustomProfileScreenHeader extends StatelessWidget {
  const CustomProfileScreenHeader({
    super.key,
    required this.user,
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(AppImages.profile),
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          style: AppStyles.text18RegularWhite,
        ),
        Text(
          user.email,
          style: AppStyles.text18RegularWhite,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
