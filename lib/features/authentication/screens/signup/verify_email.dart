import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molla/features/authentication/controllers/verify_email/verify_email.controller.dart';

import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';
import 'package:molla/utils/helpers/helper_functions.dart';
import 'package:molla/features/authentication/screens/login/login.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const Login()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Image
            Image(
              image: const AssetImage(TImages.deliveredEmailIllustration),
              width: THelperFunctions.screenWidth(context) * 0.6,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Title & SubTitle
            Text(
              TTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              FirebaseAuth.instance.currentUser?.email ??
                  'support@codingwithth.com',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Status & Actions
            Obx(() => Column(
                  children: [
                    Text(
                      ctrl.isVerified.value
                          ? 'Email verified'
                          : 'Waiting for verification...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Resend button with countdown
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (ctrl.isSending.value ||
                                ctrl.resendSeconds.value > 0)
                            ? null
                            : () => ctrl.sendEmailVerification(),
                        child: ctrl.isSending.value
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                ctrl.resendSeconds.value > 0
                                    ? 'Resend in ${ctrl.resendSeconds.value}s'
                                    : TTexts.resendEmail,
                              ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Optional manual check button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => ctrl.manualCheck(),
                        child: const Text("I've verified"),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
