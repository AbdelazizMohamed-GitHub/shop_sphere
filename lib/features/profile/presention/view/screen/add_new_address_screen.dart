import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';
import 'package:uuid/uuid.dart';

import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({
    super.key,
    required this.isupdate,
    this.addressEntity,
  });
  final bool isupdate;
  final AddressEntity? addressEntity;
  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.isupdate) {
      titleController.text = widget.addressEntity!.title;
      phoneController.text = widget.addressEntity!.phoneNumber;
      streetController.text = widget.addressEntity!.street;
      cityController.text = widget.addressEntity!.city;
      stateController.text = widget.addressEntity!.state;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isupdate
            ? const Text("Update Address")
            : const Text('Add New Address'),
        leadingWidth: 100,
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressSuccess) {
           
            Navigator.pop(context);
            Warning.showWarning(context,
                message: widget.isupdate
                    ? "Address Update Successfully"
                    : "Address Added Successfully");
          }
          if (state is AddressError) {
            Warning.showWarning(context, message: state.errMessage);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                top: 30,
                left: 16,
                right: 16,
                bottom: (MediaQuery.of(context).viewInsets.bottom) + 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextForm(
                    textController: titleController,
                    pIcon: Icons.title_rounded,
                    text: "Title",
                    kType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                    pIcon: Icons.phone,
                    textController: phoneController,
                    text: "Phone Number",
                    kType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextForm(
                            textController: streetController,
                            pIcon: Icons.streetview,
                            text: "Street",
                            kType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextForm(
                            textController: cityController,
                            pIcon: Icons.location_city,
                            text: "City",
                            kType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                    pIcon: Icons.location_searching,
                    text: "State",
                    kType: TextInputType.name,
                    textController: stateController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is AddressLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var addressId = const Uuid().v4();
                              AddressModel addressModel = AddressModel(
                                createdAt: Timestamp.now(),
                                id: widget.isupdate
                                    ? widget.addressEntity!.id
                                    : addressId,
                                title: titleController.text,
                                phoneNumber: phoneController.text,
                                street: streetController.text,
                                city: cityController.text,
                                state: stateController.text,
                                country: "Egypt",
                                postalCode: "11511",
                              );
                              if (widget.isupdate) {
                                await context
                                    .read<AddressCubit>()
                                    .updateAddress(addressId: widget.addressEntity!.id,
                                        addressModel: addressModel);
                                       
                              } else {
                                await context
                                    .read<AddressCubit>()
                                    .addAddress(addressId: addressId,
                                      addressModel: addressModel);
                                    
                              }
                            }
                          },
                          text: widget.isupdate ? "Update" : "Save",
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
