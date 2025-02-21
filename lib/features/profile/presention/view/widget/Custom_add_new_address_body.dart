import 'package:flutter/material.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';

class CustomAddNewAddressBody extends StatelessWidget {
  const CustomAddNewAddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 30,
          left: 16,
          right: 16,
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomTextForm(
            pIcon: Icons.title_rounded,
            text: "Title",
            kType: TextInputType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomTextForm(
            pIcon: Icons.phone,
            text: "Phone Number",
            kType: TextInputType.phone,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextForm(
                    pIcon: Icons.streetview,
                    text: "Street",
                    kType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextForm(
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
          const CustomTextForm(
            pIcon: Icons.location_searching,
            text: "State",
            kType: TextInputType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Save",
          )
        ],
      ),
    );
  }
}
