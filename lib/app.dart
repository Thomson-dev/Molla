import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:molla/features/authentication/screens/onboarding.screen/onboarding.page.dart';
import 'package:molla/features/authentication/screens/login/login.dart';
import 'package:molla/features/authentication/screens/signup/signup.dart';

import 'package:molla/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system, // Uses system setting
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme, // Light theme
      darkTheme: TAppTheme.darkTheme, // Dark theme
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => const Login()),
         GetPage(name: '/signup', page: () => const Signup()),
      ],
    );
  }
}
