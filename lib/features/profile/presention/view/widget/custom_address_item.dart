// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/funcation/funcations.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';

class CustomAddressItem extends StatelessWidget {
  const CustomAddressItem({
    super.key,
    required this.addressEntity,
  });
  final AddressEntity addressEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return InkWell(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title:state is AdressLoading ? const CircularProgressIndicator(): const Text("Are You Sure for Delet Address"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: ()async {
                             await context
                                  .read<AddressCubit>()
                                  .deleteAddress(addressId: addressEntity.id);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete")),
                      ],
                    ));
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.isLightTheme(context)
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
                    style: AppStyles.text16Bold,
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
                Text(
                  addressEntity.phoneNumber,
                  style: AppStyles.text16Regular,
                ),
                Text(
                  "${addressEntity.city}, ${addressEntity.street} Egypt",
                  style: AppStyles.text16Regular,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
