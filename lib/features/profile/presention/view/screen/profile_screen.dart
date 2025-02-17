// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                            size: 20,
                          )))
                ],
              ),
              const Text(
                'User Name',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(
                'Email',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                    contentPadding: EdgeInsets.zero,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.person_outlined),
                    title: Text('Profile'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
              ),
              const Divider(
                color: Colors.white,
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.logout_outlined),
                title: Text('Log Out'),
              ),
            ],
          ),
        ));
  }
}
