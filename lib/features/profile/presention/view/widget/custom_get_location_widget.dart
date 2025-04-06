// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shop_sphere/core/loading/custom_get_loaction_loading.dart';
import 'package:shop_sphere/core/loading/custom_item_loading.dart';

import 'package:shop_sphere/core/service/location_service.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';

class CustomGetLocationWidget extends StatefulWidget {
  const CustomGetLocationWidget({
    Key? key,
    required this.currentIndex,
    required this.onLocationSelected,
  }) : super(key: key);
  final int currentIndex;
  final ValueChanged<AddressModel> onLocationSelected;
  @override
  State<CustomGetLocationWidget> createState() =>
      _CustomGetLocationWidgetState();
}


class _CustomGetLocationWidgetState extends State<CustomGetLocationWidget> {
  late Placemark place;
  String title = "Title";
  String city = "City";
  String street = "Street";
  String phoneNumber = "Phone Number";
  bool isInisialzed = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
      if (state is AddressLoading) {
        return const CustomItemLoading();
      }
      if (state is AddressError) {
        return Center(
          child: Text(
            state.errMessage,
            style: AppStyles.text16Regular,
          ),
        );
      }
      if (state is AddressSuccess && !isInisialzed) {
        if (state.addresses.isNotEmpty) {
          title = state.addresses[widget.currentIndex].title;
          city = state.addresses[widget.currentIndex].city;
          street = state.addresses[widget.currentIndex].street;
          phoneNumber = state.addresses[widget.currentIndex].phoneNumber;
     
WidgetsBinding.instance.addPostFrameCallback((_) {
  AddressModel addressModel = AddressModel(
    id: state.addresses[widget.currentIndex].id,
    title: state.addresses[widget.currentIndex].title,
    city: state.addresses[widget.currentIndex].city,
    street: state.addresses[widget.currentIndex].street,
    phoneNumber: state.addresses[widget.currentIndex].phoneNumber,country: state.addresses[widget.currentIndex].country,
    state: state.addresses[widget.currentIndex].state,
    postalCode: state.addresses[widget.currentIndex].postalCode,
    createdAt: Timestamp.now(),
  );
      widget.onLocationSelected(addressModel);
    });        
          isInisialzed = true;
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.text16Bold,
          ),
          Text(
            phoneNumber,
            style: AppStyles.text16Regular,
          ),
          Text(
            "$city, $street",
            style: AppStyles.text16Regular,
          ),
          const SizedBox(
            height: 10,
          ),
          loading
              ?const CustomGetLoactionLoading()
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            AppImages.map,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withValues(alpha: 0.5)),
                    ),
                    CustomCircleButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                        ),
                        funcation: () async {
                          setState(() {
                            loading = true;
                          });
                          place = await getLocation();
                          setState(() {
                            title = "My Location";
                            city = place.locality!;
                            street = place.street!;
                            
                          });
                          widget.onLocationSelected(AddressModel(
                            createdAt: Timestamp.now(),
                              title: title,
                              city: city,
                              street: street,
                              state: place.administrativeArea!,
                              country: place.country!,
                              phoneNumber: phoneNumber, id:'', postalCode: '' ));
                          loading = false;
                        })
                  ],
                ),
        ],
      );
    });
  }
}
