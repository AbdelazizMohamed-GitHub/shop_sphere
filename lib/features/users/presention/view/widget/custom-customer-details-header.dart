import 'package:flutter/material.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';

class CustomCustomerDetailsHeader extends StatelessWidget {
  const CustomCustomerDetailsHeader({super.key, required this.customer});

  final UserEntity customer;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.backgroundColor,
              child: ClipOval(
                child: customer.profileImage.isEmpty
                    ? Image.asset(AppImages.profile)
                    : Image.network(
                        customer.profileImage,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 44),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(customer.name, style: AppStyles.text18RegularWhite),
            const SizedBox(height: 12),
            ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.backgroundColor,
                  child: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  customer.email,
                  style: AppStyles.text16BoldWhite,
                )),
            ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.backgroundColor,
                  child: Icon(
                    Icons.phone_outlined,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                    customer.phoneNumber.isEmpty
                        ? 'Phone number not provided'
                        : customer.phoneNumber,
                    style: AppStyles.text16BoldWhite)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
