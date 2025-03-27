import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/errors/fairebase_failure.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/presention/view/screen/add_new_address_screen.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_address_item.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("address").snapshots(),
      builder: (context, snapshot) {
    
    
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                        "Error: ${FirebaseFailure.fromCode(snapshot.error.toString()).message}"));
              }
              if (snapshot.hasData || snapshot.data != null) {
                List<AddressModel> addresses = [];
                for (var element in snapshot.data!.docs) {
                  addresses.add(AddressModel.fromMap(element.data()));
                }
                return addresses.isEmpty
                    ? const Center(
                        child: Text(
                          "No Address",
                          style: AppStyles.text18Regular,
                        ),
                      )
                    : ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          return CustomAddressItem(
                            addressEntity: addresses[index],
                          );
                        });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
                 
    );
  }
}
