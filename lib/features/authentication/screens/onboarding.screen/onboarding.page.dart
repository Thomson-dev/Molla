import 'package:flutter/material.dart';

import 'package:molla/features/authentication/controllers/onboarding.controller/onboarding_controller.dart';
import 'package:molla/features/authentication/screens/onboarding.screen/onboarding.widget.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final controller = OnBoardingController.instance; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Center(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndicator,
                children: [
                  onboardingPage(
                    context: context,
                    imageUrl: TImages.onBoardingImage1,
                    title: TTexts.onBoardingTitle1,
                    subtitle: TTexts.onBoardingSubTitle1,
                  ),
                  onboardingPage(
                    context: context,
                    imageUrl: TImages.onBoardingImage2,
                    title: TTexts.onBoardingTitle2,
                    subtitle: TTexts.onBoardingSubTitle3,
                  ),
                  onboardingPage(
                    context: context,
                    imageUrl: TImages.onBoardingImage3,
                    title: TTexts.onBoardingTitle3,
                    subtitle: TTexts.onBoardingSubTitle3,
                  ),
                ],
              ),
            ),
          ),

          // Skip Button
          SkipButton(),

          // Dot Navigation SmoothPageIndicator
          OnboardingDotsIndicator(
            controller: controller.pageController,
            count: 3,
          ),

          // Circular Button
          OnboardingNextButton(onPressed: controller.nextPage),
        ],
      ),
    );
  }
}
