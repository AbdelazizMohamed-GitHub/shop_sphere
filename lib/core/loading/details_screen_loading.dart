import 'package:flutter/material.dart';

import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailsScreenLoading extends StatelessWidget {
  const DetailsScreenLoading({super.key}
    
   
  );
 
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(children: [
               SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(children: [
        Positioned(
            top: 50,
            left: 50,
            right: 10,
            bottom: 0,
            child:
                 Container(
                 decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
                
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
               
                       CustomCircleButton(
                          icon:const Icon(Icons.favorite_border),
                          funcation: () {},
                        )
                      
                   ,
                 
             
          
            const SizedBox(
              height: 10,
            ),
            Text('Perfume', style: AppStyles.text22SemiBoldBlack),
            const SizedBox(
              height: 10,
            ),
            Text('\$30',
                style: AppStyles.text16Bold),
          ]),
        ]  ),

       
             const SizedBox(
          height: 10,
        ),]),
    ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: Text(
                    '  Perfumes vary in their compositions and longevity, ranging from highly concentrated perfumes (like "Parfum") to lighter fragrances (like "Eau de Cologne"). Each perfume is distinguished by its unique ingredients, which may be floral, woody, citrusy, or oriental, reflecting a distinctive character and personality for each wearer. 🌿✨',
                    style: const TextStyle(fontSize: 16),
                  
                  ),
                ),
              
                const SizedBox(
                  height: 10,
                ),
              
              ]),
            )),
        bottomNavigationBar: Container(margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),  
        )
      ),
    );
  }
}
