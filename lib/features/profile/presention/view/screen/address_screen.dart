import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_address_item.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressCubit(addressRepo: getIt<AddressRepoImpl>())..getAddress(),
      child: Scaffold(
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
        body: BlocListener<AddressCubit, AddressState>(
          listener: (context, state) {
          if (state is AdressSuccess) {
          
            BlocProvider.of<AddressCubit>(context).getAddress();
            
          }
          },
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return state is GetAdressLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is GetAdressSuccess
                      ? state.addresses.isEmpty
                          ? const Center(
                              child: Text(
                                "No Address",
                                style: AppStyles.text18Regular,
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.addresses.length,
                              itemBuilder: (context, index) {
                                return CustomAddressItem(
                                  addressEntity: state.addresses[index],
                                );
                              })
                      : state is AdressError
                          ? Center(child: Text(state.errMessage))
                          : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
