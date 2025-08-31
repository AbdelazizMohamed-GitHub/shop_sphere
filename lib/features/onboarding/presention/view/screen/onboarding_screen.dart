import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/features/onboarding/presention/view/widget/custom_inboarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  currentPage = value;
                  setState(() {});
                },
                children: const [
                  CustomOnboardingItem(
                      bodyImage: AppImages.onboarding1,
                      bodyText: 'Purchase Online !!'),
                  CustomOnboardingItem(
                      bodyImage: AppImages.onboarding2,
                      bodyText: 'Fast Delivery !!'),
                  CustomOnboardingItem(
                      bodyImage: AppImages.onboarding3,
                      bodyText: 'Get your order !!')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (currentPage > 0) {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Back",
                        style: AppStyles.text22SemiBold,
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  SmoothPageIndicator(
                    controller: PageController(initialPage: currentPage),
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const ScrollingDotsEffect(
                        activeDotColor: AppColors.primaryColor),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (currentPage < 2) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        context.goNamed(AppRoute.login);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: currentPage == 2
                          ? Text(' Start Shopping',
                              style: AppStyles.text16Regular
                                  .copyWith(color: Colors.white))
                          : const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
