import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/features/authentication/screens/password_config/forget_password.dart';
import 'package:molla/navigation_menu.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';
import 'package:molla/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:molla/utils/constants/image_strings.dart';

class LoginHeader extends StatelessWidget {
  final bool dark;
  const LoginHeader({required this.dark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image(
        //   height: 150,
        //   image: AssetImage(dark ? TImages.lightAppLogo : TImages.lightAppLogo),
        // ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const LoginForm({
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: const Icon(Iconsax.eye_slash),
            ),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields / 2),

          // Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember Me
              Row(
                children: [
                  Checkbox(value: rememberMe, onChanged: onRememberMeChanged),
                  Text(TTexts.rememberMe),
                ],
              ),
              // Forgot Password
              TextButton(
                onPressed: () {
                  Get.to(() => ForgetPassword());
                  // TODO: Implement forgot password navigation
                },
                child: const Text(TTexts.forgotPassword),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  const LoginButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Sign In Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const NavigationMenu());
            },
            child: const Text(TTexts.signIn),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Account Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Get.toNamed('/signup');
            },
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    );
  }
}
