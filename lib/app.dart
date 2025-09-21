import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molla/features/authentication/repositories/authentication_repository.dart';

import 'package:molla/features/authentication/screens/signup/verify_email.dart';
import 'package:molla/navigation_menu.dart';
import 'package:molla/utils/theme/theme.dart';

import 'features/authentication/screens/login/login.dart';
import 'features/authentication/screens/signup/signup.dart';
import 'features/authentication/screens/onboarding.screen/onboarding.page.dart';
import 'features/authentication/controllers/onboarding.controller/onboarding_controller.dart';

/// Root of the application
/// Entry point for app configuration & initialization
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Setup GetX-based navigation and app theme configuration
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      themeMode: ThemeMode.system, // Use system theme preference
      // Theme configuration
      theme: TAppTheme.lightTheme, // Light theme
      darkTheme: TAppTheme.darkTheme, // Dark theme
      // Navigation configuration
      initialRoute: '/', // Start at splash/wrapper
      // Route definitions with GetX page management
      getPages: [
        // Initial route shows SplashWrapper for auth checking and routing
        GetPage(name: '/', page: () => const SplashWrapper()),

        // Onboarding screen with controller binding
        // Only shown on first app launch
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          binding: BindingsBuilder(() {
            // Lazy initialize controller when needed
            Get.lazyPut<OnBoardingController>(() => OnBoardingController());
          }),
        ),

        // Authentication routes
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/signup', page: () => const Signup()),
      ],
    );
  }
}

/// SplashWrapper handles initial app flow:
/// - Checks if first time use (onboarding needed)
/// - Shows loading while initializing
/// - Redirects to appropriate screen based on auth state
class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Get auth repository to check user state
    final authRepo = Get.find<AuthenticationRepository>();

    // Use Obx to react to changes in initialization state
    return Obx(() {
      // STEP 1: Check if this is first app launch (needs onboarding)
      final bool showOnboarding =
          authRepo.deviceStorage.read("isFirstTime") == true;

      // Ensure onboarding controller exists if needed
      if (showOnboarding && !Get.isRegistered<OnBoardingController>()) {
        Get.put(OnBoardingController());
      }

      // STEP 2: Determine which base screen to show while initializing
      final Widget base = showOnboarding ? OnboardingScreen() : const Login();

      // STEP 3: Show loading overlay if still initializing
      if (authRepo.isInitializing.value) {
        return Stack(
          children: [
            base, // Show base screen underneath
            Positioned.fill(
              // Semi-transparent loading overlay
              child: Container(
                color: Colors.black.withOpacity(0.45),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }

      // STEP 4: Initialization complete - handle redirect after frame renders
      // This prevents build/layout issues during navigation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _redirect(authRepo, FirebaseAuth.instance.currentUser);
      });

      // Return base screen (will be replaced by redirect)
      return base;
    });
  }

  /// Handles navigation logic after initialization
  /// Routes user to appropriate screen based on authentication state
  Future<void> _redirect(AuthenticationRepository authRepo, User? user) async {
    // Safety check: avoid multiple redirects
    if (Get.currentRoute != '/' && Get.currentRoute != '') return;

    // CASE 1: User is authenticated
    if (user != null) {
      if (user.emailVerified) {
        // Verified user → main app
        Get.offAll(() => const NavigationMenu());
      } else {
        // Unverified user → verification screen
        Get.offAll(() => const VerifyEmailScreen());
      }
      return;
    }

    // CASE 2: No authenticated user - check first-time status
    final storage = authRepo.deviceStorage;

    // Initialize first-time flag if not set
    if (!storage.hasData('isFirstTime')) {
      storage.write('isFirstTime', true);
    }

    final bool isFirstTime = storage.read('isFirstTime') == true;

    if (isFirstTime) {
      // First launch → show onboarding & mark as seen
      storage.write('isFirstTime', false);
      Get.offAll(() => OnboardingScreen());
    } else {
      // Returning user → login screen
      Get.offAll(() => const Login());
    }
  }
}
