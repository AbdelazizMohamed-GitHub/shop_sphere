import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/utils/app_route.dart';

class CustomExploreScreenSearch extends StatelessWidget {
  const CustomExploreScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                context.pushNamed(AppRoute.productSearch);
              },
              child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: const Row(children: [
                    SizedBox(width: 10),
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(width: 10),
                    Text('Search For Products', style: AppStyles.text16Regular),
                  ])),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoute.chatbot,
                    extra: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
                icon: const Icon(
                  Icons.support_agent,
                  size: 30,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
