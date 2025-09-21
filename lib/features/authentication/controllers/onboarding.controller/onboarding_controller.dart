import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;

  /// Update Current Index when Page Scroll
  void updatePageIndicator(int index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page.
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if (currentPageIndex.value < 2) {
      // Assuming 3 onboarding pages (0, 1, 2)
      currentPageIndex.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Mark onboarding as completed when reaching the end
      final storage = GetStorage();
      storage.write('isFirstTime', false);

      // Navigate to LoginPage
      Get.offAllNamed('/login');
    }
  }

  /// Update Current Index & jump to the last Page
  void skipPage() {
    currentPageIndex.value = 2; // Change to your last page index
    pageController.jumpToPage(2);

    // Mark onboarding as completed when skipping
    final storage = GetStorage();
    storage.write('isFirstTime', false);
  }
}
