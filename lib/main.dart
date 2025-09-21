import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:molla/features/authentication/repositories/authentication_repository.dart';

import 'firebase_options.dart';
import 'package:molla/features/authentication/controllers/onboarding.controller/onboarding_controller.dart';
import 'package:molla/features/authentication/controllers/setting/setting.controller.dart';

import 'app.dart';

/// Entry point of the Flutter app
Future<void> main() async {
  // Widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Force specific status bar style for entire app
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // ✅ Light background (important!)
      statusBarIconBrightness: Brightness.dark, // ✅ Android → Dark icons
      statusBarBrightness: Brightness.light, // ✅ iOS → Dark icons
    ),
  );

  // Local storage
  await GetStorage.init();

  // Keep splash until resources load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase and Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) {
    Get.put(AuthenticationRepository());
    Get.put(OnBoardingController());
    Get.put(SettingsController());
  });

  // Run the app
  runApp(const App());
}
