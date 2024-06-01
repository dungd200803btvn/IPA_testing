import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/controller/onboarding/onboard_controller.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/onboard_next_button.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/onboard_skip.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_string.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return  Scaffold(
      body: Stack(
        children: [
          //Horizon Page scroll view
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingWidget(
                image: TImages.onBoardingImage1,
                title: DText.onBoardingTitle1,
                subTitle: DText.onBoardingSubTitle1,
              ),
              OnboardingWidget(
                image: TImages.onBoardingImage2,
                title: DText.onBoardingTitle2,
                subTitle: DText.onBoardingSubTitle2,
              ),
              OnboardingWidget(
                image: TImages.onBoardingImage3,
                title: DText.onBoardingTitle3,
                subTitle: DText.onBoardingSubTitle3,
              ),
            ],
          ),
          
          //Skip button
            const onBoardingSkip(),
          //Dot navigation SmoothPageIndicator
         const onBoardingDotNavigation(),
        //circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}







