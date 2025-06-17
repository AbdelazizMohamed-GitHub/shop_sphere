// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/loading/address_screen_loadig.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';
import 'package:shop_sphere/features/profile/presention/controller/profile/user_cubit.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_address_item.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    super.key,
    required this.selectAddressIndex,
  });
  final int selectAddressIndex;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectAddressIndex = 0;
  @override
  void initState() {
    context.read<AddressCubit>().getAddress();
    selectAddressIndex = widget.selectAddressIndex;
    super.initState();
  }

  int? indeX;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewAddressScreen(
                      isupdate: false,
                    ),
                  ));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            )),
        appBar: AppBar(
          actions: [
            indeX == null
                ? const Text('')
                : TextButton(
                    onPressed: () async {
                      await context.read<AddressCubit>().updateAddressIndex(
                          sellectAddress: selectAddressIndex);

                      context.read<UserCubit>().getUserData();
                    },
                    child: const Text('Save', style: AppStyles.text16Bold)),
            const SizedBox(
              width: 20,
            )
          ],
          title: const Text('Address'),
          leadingWidth: 100,
          leading: AppTheme.isLightTheme(context)
              ? const CustomBackButton()
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  )),
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(child: AddressScreenLoading());
            }
            if (state is AddressError) {
              return CustomErrorWidget(
                errorMessage: state.errMessage.toString(),
                onpressed: () async {
                  await context.read<AddressCubit>().getAddress();
                },
              );
            }
            if (state is AddressSuccess) {
              return state.addresses.isEmpty
                  ? const Center(
                      child: Text(
                        'No Address Found',
                        style: AppStyles.text16Bold,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.addresses.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectAddressIndex = index;
                            });
                            indeX = index;
                          },
                          child: CustomAddressItem(
                            addressEntity: state.addresses[index],
                            isSelect: index == selectAddressIndex,
                          ),
                        );
                      });
            }
            return const Center(
              child: Text(
                'Something went wrong',
                style: AppStyles.text16Bold,
              ),
            );
          },
        ));
  }
}
