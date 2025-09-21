import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:molla/features/authentication/repositories/authentication_repository.dart';
import 'package:molla/navigation_menu.dart';
import 'package:molla/utils/popups/fullscreen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Add this property to flag when controller is being disposed
  bool _isDisposed = false;

  final RxBool rememberMe = false.obs;
  final RxBool obscureText = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GetStorage box = GetStorage();

  void togglePasswordVisibility() => obscureText.toggle();
  void toggleRememberMe() => rememberMe.toggle();

  @override
  void onInit() {
    super.onInit();
    _loadSavedEmail();
  }

  @override
  void onClose() {
    _isDisposed = true;
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Add a factory method for safe creation of controllers
  static void init() {
    try {
      // Only create a new instance if one doesn't exist
      if (!Get.isRegistered<LoginController>()) {
        Get.put(LoginController(), permanent: false);
      }
    } catch (e) {
      debugPrint('LoginController init error: $e');
    }
  }

  bool _validateForm() {
    if (loginFormKey.currentState?.validate() ?? false) return true;
    Get.snackbar(
      'Invalid',
      'Please complete the form correctly.',
      snackPosition: SnackPosition.BOTTOM,
    );
    return false;
  }

  void _loadSavedEmail() {
    final savedEmail = box.read('REMEMBER_ME_EMAIL');
    if (savedEmail != null) {
      emailController.text = savedEmail;
      rememberMe.value = true;
    }
  }

  /// Handle email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    if (!_validateForm()) return;

    try {
      // Show loading indicator
      TFullScreenLoader.openLoadingDialog('Logging you in...');

      // Handle remember-me functionality
      if (rememberMe.value) {
        box.write('REMEMBER_ME_EMAIL', emailController.text.trim());
      } else {
        box.remove('REMEMBER_ME_EMAIL');
        box.remove('REMEMBER_ME_PASSWORD');
      }

      // Perform login
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text.trim(),
          );

      // Stop loading before navigation
      TFullScreenLoader.stopLoading();

      // Navigate to home screen on successful login
      if (!_isDisposed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Get.isRegistered<LoginController>()) {
            Get.offAll(() => const NavigationMenu());
          }
        });
      }
    } catch (e) {
      // Stop loader and show error
      TFullScreenLoader.stopLoading();
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    }
  }

  // Google sign-in method
  //   Future<void> googleSignIn() async {
  //     try {
  //       TFullScreenLoader.openLoadingDialog('Logging in with Google...');
  //       await AuthenticationRepository.instance.signInWithGoogle();
  //       TFullScreenLoader.stopLoading();

  //       if (!_isDisposed) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           Get.offAll(() => const NavigationMenu());
  //         });
  //       }
  //     } catch (e) {
  //       TFullScreenLoader.stopLoading();
  //       Get.snackbar(
  //         'Google Sign In Failed',
  //         e.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   }

  //   // Facebook sign-in method
  //   Future<void> facebookSignIn() async {
  //     try {
  //       TFullScreenLoader.openLoadingDialog('Logging in with Facebook...');
  //       // Implement this in AuthenticationRepository
  //       await AuthenticationRepository.instance.signInWithFacebook();
  //       TFullScreenLoader.stopLoading();

  //       if (!_isDisposed) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           Get.offAll(() => const NavigationMenu());
  //         });
  //       }
  //     } catch (e) {
  //       TFullScreenLoader.stopLoading();
  //       Get.snackbar(
  //         'Facebook Sign In Failed',
  //         e.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   }

  /// Handle user logout
  Future<void> logout() async {
    try {
      // Show loading indicator
      TFullScreenLoader.openLoadingDialog('Logging out...');

      // Call the repository logout method
      await AuthenticationRepository.instance.logout();

      // Clear local user data
      final box = GetStorage();
      box.remove(
        'REMEMBER_ME_PASSWORD',
      ); // Only remove password, keep email for convenience

      // Stop loading indicator
      TFullScreenLoader.stopLoading();

      // Navigate to login screen - this is typically handled in the repository's logout method
      // but adding here as a fallback
      if (!_isDisposed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(
            '/login',
          ); // Replace with your login route if different
        });
      }
    } catch (e) {
      // Stop loader and show error
      TFullScreenLoader.stopLoading();
      Get.snackbar(
        'Logout Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    }
  }
}
