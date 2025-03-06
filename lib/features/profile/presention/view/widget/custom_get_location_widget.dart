// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/service/location_service.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';

class CustomGetLocationWidget extends StatefulWidget {
  const CustomGetLocationWidget({
    super.key,
  });

  @override
  State<CustomGetLocationWidget> createState() =>
      _CustomGetLocationWidgetState();
}

class _CustomGetLocationWidgetState extends State<CustomGetLocationWidget> {
  late Placemark place;
  String title = "My Home";
  String city = "Cairo";
  String street = "3 El Nozha Street";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.text16Bold,
        ),
        const Text(
          "01153019984",
          style: AppStyles.text16Regular,
        ),
        Text(
          "$city, $street",
          style: AppStyles.text16Regular,
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
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
                  place = await getLocation();
                  setState(() {
                    title = "Current Location";
                    city = place.locality!;
                    street = place.street!;
                  });
                })
          ],
        ),
      ],
    );
  }
}
