import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:molla/features/authentication/screens/password_config/forget_password.dart';
import 'package:molla/navigation_menu.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';
import 'package:molla/utils/helpers/helper_functions.dart';

class LoginHeader extends StatelessWidget {
  final bool dark;
  const LoginHeader({required this.dark, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Uncomment / adjust image if you have a logo asset
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
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;
  final ValueChanged<bool?> onRememberMeChanged;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.obscureText,
    required this.togglePasswordVisibility,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email required';
              if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
              return null;
            },
          ),
          SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            controller: passwordController,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(
                icon: Icon(obscureText ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: togglePasswordVisibility,
              ),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Password required';
              if (v.trim().length < 6) return 'Minimum 6 characters';
              return null;
            },
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
                  const SizedBox(width: 6),
                  Text(TTexts.rememberMe),
                ],
              ),
              // Forgot Password
              TextButton(
                onPressed: () {
                  Get.to(() => ForgetPassword());
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
  final VoidCallback onSignIn;
  final VoidCallback? onCreateAccount;

  const LoginButtons({super.key, required this.onSignIn, this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Sign In Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSignIn,
            child: const Text(TTexts.signIn),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Account Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed:
                onCreateAccount ??
                () {
                  Get.toNamed('/signup');
                },
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    );
  }
}
