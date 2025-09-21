import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molla/features/authentication/screens/login/login.dart';
import 'package:molla/widget/success/successScreen.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool isSending = false.obs;
  final RxBool isVerified = false.obs;
  final RxInt resendSeconds = 0.obs;

  DateTime? lastSentAt;
  final Duration resendCooldown = const Duration(seconds: 30);

  StreamSubscription<User?>? _userChangeSub;
  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification(); // send immediately when screen appears
    _listenForVerification(); // event-driven verification
  }

  @override
  void onClose() {
    _userChangeSub?.cancel();
    _countdownTimer?.cancel();
    super.onClose();
  }

  /// Send verification email
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar(
        'Error',
        'No authenticated user found.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Rate limit resend
    if (lastSentAt != null &&
        DateTime.now().difference(lastSentAt!) < resendCooldown) {
      Get.snackbar(
        'Please wait',
        'You can resend in ${resendSeconds.value}s',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSending.value = true;
      await user.sendEmailVerification();
      lastSentAt = DateTime.now();
      _startCountdown();
      Get.snackbar(
        'Sent',
        'Verification email sent.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSending.value = false;
    }
  }

  /// Start reactive countdown for resend button
  void _startCountdown() {
    _countdownTimer?.cancel();
    resendSeconds.value = resendCooldown.inSeconds;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value <= 1) {
        resendSeconds.value = 0;
        timer.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }

  /// Listen to user changes instead of polling
  void _listenForVerification() {
    _userChangeSub = _auth.userChanges().listen((user) async {
      try {
        await user?.reload();
        if (user?.emailVerified ?? false) {
          isVerified.value = true;

          // Cancel listener BEFORE navigating to avoid further emissions
          await _userChangeSub?.cancel();
          _userChangeSub = null;

          Get.snackbar(
            'Verified',
            'Email verified, redirecting...',
            snackPosition: SnackPosition.BOTTOM,
          );

          // Small delay to let snackbar show, then navigate
          await Future.delayed(const Duration(milliseconds: 500));

          // Optional safety: close overlays/dialogs before navigation
          if (Get.isOverlaysOpen) Get.back();

          Get.offAll(
            () => SuccessScreen(
              image: 'assets/images/verify-image.png',
              title: 'Email Verified!',
              subTitle: 'Your email has been successfully verified.',
              onPressed: () {
                Get.offAll(() => Login());
              },
            ),
          );
        }
      } catch (e) {
        debugPrint('verify listener error: $e');
      }
    });
  }

  /// Manual check (optional button)
  Future<void> manualCheck() async {
    final user = _auth.currentUser;
    await user?.reload();
  }
}
