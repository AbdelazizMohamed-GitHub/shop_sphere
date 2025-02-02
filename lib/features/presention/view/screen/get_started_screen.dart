import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(AppImages.logo,height: 300,),
        const SizedBox(height: 20,),
        const Text("Disvcover the joy of effortless hopping with shopSphere",style:AppStyles.text22SemiBoldBlack),
       const SizedBox(height: 10,),CustomButton(onPressed: (){}, text: "Get Started")
      ],),
    );
  }
}