import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molla/features/authentication/screens/login/login.dart';
import 'package:molla/features/authentication/screens/signup/verify_email.dart';
import 'package:molla/features/authentication/model/user_model.dart';
import 'package:molla/utils/exceptions/firebase_exceptions.dart';
import 'package:molla/features/authentication/repositories/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // UI State
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  final acceptTerms = false.obs;

  // Text Controllers
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    super.onClose();
  }

  void togglePasswordView() => isPasswordHidden.value = !isPasswordHidden.value;

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await AuthenticationRepository.instance.registerWithEmailAndPassword(
      email,
      password,
    );
  }

  /// Main signup logic
  Future<void> signup() async {
    try {
      isLoading.value = true;

      // Validate form
      if (!signupFormKey.currentState!.validate()) {
        Get.snackbar(
          'Invalid',
          'Please complete the form correctly.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Check terms
      if (!acceptTerms.value) {
        Get.snackbar(
          'Terms',
          'You must accept Privacy Policy & Terms of Use.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Register user
      final userCred = await registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final uid = userCred.user?.uid ?? '';
      if (uid.isEmpty) throw Exception('Failed to create user.');

      // Build user model
      final generatedUsername =
          username.text.trim().isNotEmpty
              ? username.text.trim()
              : (fullName.text.trim().isNotEmpty
                  ? UserModel.generateUsername(fullName.text.trim())
                  : 'user_${DateTime.now().millisecondsSinceEpoch}');

      final newUser = UserModel(
        id: uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: generatedUsername,
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        isEmailVerified: userCred.user?.emailVerified ?? false,
        isProfileActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        verificationStatus: '',
      );

      // Save to Firestore using the enhanced error handling method
      try {
        await AuthenticationRepository.instance.saveUserRecord(newUser);
      } catch (e) {
        await userCred.user?.delete(); // rollback auth user if Firestore fails
        rethrow;
      }

      // Send email verification (non-fatal)
      if (userCred.user != null && !(userCred.user!.emailVerified)) {
        try {
          await userCred.user!.sendEmailVerification();
        } catch (_) {
          Get.snackbar(
            'Notice',
            'Unable to send verification email. Please check later.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }

      // Success message
      Get.snackbar(
        'Congratulations',
        'Account created. Verification email sent if required.',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate
      if (userCred.user?.emailVerified ?? false) {
        Get.offAll(() => Login());
      } else {
        Get.offAll(() => const VerifyEmailScreen());
      }
    } on FirebaseAuthException catch (e) {
      final message = _friendlyAuthMessage(e);
      Get.snackbar(
        'Signup failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TFirebaseException catch (e) {
      Get.snackbar(
        'Database Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TFormatException catch (e) {
      Get.snackbar(
        'Format Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TPlatformException catch (e) {
      Get.snackbar(
        'Platform Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Firebase error',
        e.message ?? 'An error occurred.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Signup error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String _friendlyAuthMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use. Try logging in or reset password.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      default:
        return e.message ?? 'Authentication error';
    }
  }

  /// Placeholder for phone authentication
  Future<void> loginWithPhoneNumber(String phoneNo) async {
    Get.snackbar(
      'Not Supported',
      'Phone login is not available yet.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
