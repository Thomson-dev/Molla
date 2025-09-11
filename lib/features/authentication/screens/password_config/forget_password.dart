import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSizes.defaultSpace),
              Text(
                'Enter your email to receive a password reset link',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: TSizes.defaultSpace * 2),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.message),
                ),
              ),
              SizedBox(height: TSizes.defaultSpace),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle password reset
                  },
                  child: Text('Send Reset Link'),
                ),
              ),
              SizedBox(height: TSizes.defaultSpace),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
