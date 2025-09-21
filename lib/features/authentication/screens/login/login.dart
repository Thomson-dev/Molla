import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'package:molla/features/authentication/controllers/login/login.controller.dart';
import 'package:molla/features/authentication/screens/login/login.widget.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';
import 'package:molla/utils/helpers/helper_functions.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Reuse existing controller or create a permanent one
    final _ctrl = Get.put(LoginController(), permanent: true);

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: TSizes.appBarHeight * 2,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Reactive login form
              Obx(
                () => LoginForm(
                  formKey: _ctrl.loginFormKey,
                  emailController: _ctrl.emailController,
                  passwordController: _ctrl.passwordController,
                  rememberMe: _ctrl.rememberMe.value,
                  obscureText: _ctrl.obscureText.value,
                  togglePasswordVisibility: _ctrl.togglePasswordVisibility,
                  onRememberMeChanged: (_) => _ctrl.toggleRememberMe(),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              LoginButtons(
                onSignIn: () => _ctrl.emailAndPasswordSignIn(),
                onCreateAccount: () => Get.toNamed('/signup'),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? Colors.grey.shade800 : Colors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    'Or Sign In With',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark ? Colors.grey.shade800 : Colors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Social login example
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: TSizes.iconMd,
                        height: TSizes.iconMd,
                        image: AssetImage(TImages.google),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
