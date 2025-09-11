import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:molla/features/authentication/screens/login/login.widget.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';

import 'package:molla/utils/helpers/helper_functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: TSizes.appBarHeight * 2,
          left: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),
              LoginForm(
                rememberMe: rememberMe,
                onRememberMeChanged: (value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              LoginButtons(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Divider
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
              // End Divider
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
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

              // Add this inside your form or at the appropriate place in your widget tree
            ],
          ),
        ),
      ),
    );
  }
}
