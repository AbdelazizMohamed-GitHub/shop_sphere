import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';

class CustomAddressItem extends StatelessWidget {
  const CustomAddressItem({
    super.key,
    required this.addressEntity,
    required this.isSelect,
  });
  final AddressEntity addressEntity;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelect
            ? AppColors.primaryColor
            : AppTheme.isLightTheme(context)
                ? Colors.white
                : AppColors.secondaryDarkColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              addressEntity.title,
              style: isSelect
                  ? AppStyles.text16Bold.copyWith(color: Colors.white)
                  : AppStyles.text16Bold,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewAddressScreen(
                          isupdate: true,
                          addressEntity: addressEntity,
                        ),
                      ));
                },
                icon: Icon(
                  Icons.edit,
                  color: AppTheme.isLightTheme(context)
                      ? Colors.black
                      : Colors.white,
                ))
          ]),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressEntity.phoneNumber,
                    style: isSelect
                        ? AppStyles.text16Regular.copyWith(color: Colors.white)
                        : AppStyles.text16Regular,
                  ),
                  Text(
                    " ${addressEntity.street},${addressEntity.city},${addressEntity.state}",
                    style: isSelect
                        ? AppStyles.text16Regular.copyWith(color: Colors.white)
                        : AppStyles.text16Regular,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    await context
                        .read<AddressCubit>()
                        .deleteAddress(addressId: addressEntity.id);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red))
            ],
          ),
        ],
      ),
    );
  }
}
