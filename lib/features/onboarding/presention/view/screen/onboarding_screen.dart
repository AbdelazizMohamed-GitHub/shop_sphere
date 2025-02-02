import 'package:flutter/material.dart';
import 'package:shop_sphere/core/constant/app_color.dart';
import 'package:shop_sphere/core/constant/app_images.dart';
import 'package:shop_sphere/core/constant/app_styles.dart';
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
                        pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      child: const Text("Back",style:AppStyles.text22SemiBoldBlack,)),
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: PageController(
                        initialPage: currentPage), // PageController
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const ScrollingDotsEffect(
                        activeDotColor: AppColors.primaryColor),
                  ),
                  const Spacer(),
                  InkWell(   onTap: () {
                        if (currentPage < 2) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStartedScreen()));
                        }
                      },
                    child: Container(padding:const EdgeInsets.all(10),
                      color: AppColors.primaryColor,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                   
                      child: currentPage == 2
                          ? const Text(' Start Shopping')
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
