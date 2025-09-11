import 'package:flutter/material.dart';
import 'package:molla/features/authentication/controllers/onboarding.controller/onboarding_controller.dart';
import 'package:molla/utils/device/device_utility.dart';
import 'package:molla/utils/theme/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/helpers/helper_functions.dart'; // Add the correct import for TSizes

Widget onboardingPage({
  required BuildContext context,
  required String imageUrl,
  required String title,
  required String subtitle,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
    padding: EdgeInsets.all(TSizes.defaultSpace),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image(
            width: THelperFunctions.screenWidth(context) * 0.9,
            height: THelperFunctions.screenHeight(context) * 0.4,
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed;

  SkipButton({Key? key, this.onPressed}) : super(key: key);
  final controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: 0,
      child: TextButton(
        onPressed:
            onPressed ??
            () {
              controller.skipPage();
            },
        child: Text(
          'Skip',
          style: TextStyle(
            color: dark ? Colors.white : TColors.dark,
            fontFamily: 'Poppins', // Use your custom font
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class OnboardingDotsIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingDotsIndicator({
    Key? key,
    required this.controller,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(context) + 40,
      left: TSizes.defaultSpace,
      right: 0,
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: ExpandingDotsEffect(
          dotColor: isDark ? Colors.white : TColors.dark,
          activeDotColor: isDark ? Colors.white : TColors.dark,
          dotHeight: 8,
          dotWidth: 8,
          spacing: 4,
        ),
      ),
    );
  }
}

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const OnboardingNextButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(context) + 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
          elevation: 6,
          backgroundColor: isDark ? Colors.blue : TColors.dark,
          foregroundColor: isDark ? TColors.dark : Colors.white,
          shadowColor: TColors.dark.withOpacity(0.2),
          side: BorderSide.none,
        ),
        child: const Icon(Icons.arrow_forward, size: 20),
      ),
    );
  }
}
