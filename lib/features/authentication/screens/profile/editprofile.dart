import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:molla/features/authentication/controllers/user/user_controller.dart';
import 'package:molla/features/authentication/controllers/setting/setting.controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = Get.find<UserController>().user.value;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    phoneController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();
    final userController = Get.find<UserController>();
    final isDark = settings.isDarkMode;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            backgroundColor:
                isDark ? const Color(0xFF0D0E12) : const Color(0xFFF6F8FB),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),
                      _HeaderBar(isDark: isDark),
                      const SizedBox(height: 30),

                      /// Avatar Section
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6A3DE8),
                                    Color(0xFFE47AE6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isDark
                                          ? const Color(0xFF1A1C20)
                                          : Colors.white,
                                ),
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor:
                                      isDark
                                          ? Colors.black26
                                          : Colors.grey.shade100,
                                  backgroundImage: NetworkImage(
                                    userController
                                            .user
                                            .value
                                            .profilePicture
                                            .isNotEmpty
                                        ? userController
                                            .user
                                            .value
                                            .profilePicture
                                        : 'https://images.unsplash.com/photo-1598550880863-4e8aa3d0edb4',
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap:
                                  _isLoading
                                      ? null
                                      : () => _showImageSourceDialog(
                                        context,
                                        isDark,
                                        userController,
                                      ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: theme.colorScheme.primary,
                                  radius: 22,
                                  child: const Icon(
                                    Iconsax.camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),

                      Text(
                        'Personal Information',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      _InputField(
                        controller: firstNameController,
                        label: 'First Name',
                        icon: Iconsax.user,
                        isDark: isDark,
                        validator:
                            (v) =>
                                v!.isEmpty
                                    ? 'Please enter your first name'
                                    : null,
                      ),
                      _InputField(
                        controller: lastNameController,
                        label: 'Last Name',
                        icon: Iconsax.user,
                        isDark: isDark,
                        validator:
                            (v) =>
                                v!.isEmpty
                                    ? 'Please enter your last name'
                                    : null,
                      ),
                      _InputField(
                        controller: phoneController,
                        label: 'Phone Number',
                        icon: Iconsax.call,
                        keyboardType: TextInputType.phone,
                        isDark: isDark,
                      ),
                      _InputField(
                        controller: emailController,
                        label: 'Email',
                        icon: Iconsax.sms,
                        isDark: isDark,
                        readOnly: true,
                        helperText: 'Email cannot be changed',
                      ),
                      const SizedBox(height: 30),

                      /// Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed:
                              _isLoading
                                  ? null
                                  : () => _updateProfile(
                                    context,
                                    formKey,
                                    userController,
                                    firstNameController.text,
                                    lastNameController.text,
                                    phoneController.text,
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: theme.colorScheme.primary
                                .withOpacity(0.6),
                            disabledForegroundColor: Colors.white70,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                            shadowColor: theme.colorScheme.primary.withOpacity(
                              0.3,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_isLoading)
                                Container(
                                  width: 18,
                                  height: 18,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              Text(
                                _isLoading ? 'Saving...' : 'Save Changes',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Divider
                      Divider(
                        color: isDark ? Colors.white24 : Colors.black12,
                        thickness: 1,
                      ),
                      const SizedBox(height: 16),

                      /// Danger Zone
                      Text(
                        'Danger Zone',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE53935),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Delete Account Button
                      _DeleteAccountButton(
                        isDark: isDark,
                        onDelete: () => _deleteAccount(userController),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🌟 Frosted Loader Overlay
          if (_isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 28,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E2126) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(strokeWidth: 3),
                          const SizedBox(height: 16),
                          Text(
                            'Updating profile...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Future<void> _updateProfile(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UserController userController,
    String firstName,
    String lastName,
    String phone,
  ) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      try {
        setState(() => _isLoading = true);

        await userController.updateUserProfile(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phone,
        );

        setState(() => _isLoading = false);
        Get.back();

        Get.snackbar(
          'Profile Updated',
          'Your profile has been updated successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Iconsax.tick_circle, color: Colors.green),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Error',
          'Failed to update profile: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Iconsax.warning_2, color: Colors.red),
        );
      }
    }
  }

  void _showImageSourceDialog(
    BuildContext context,
    bool isDark,
    UserController userController,
  ) {
    if (_isLoading) return;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: isDark ? const Color(0xFF1E2126) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Choose Image Source',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ImageSourceOption(
                  icon: Iconsax.camera,
                  title: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    // _pickImage(ImageSource.camera, userController);
                  },
                  isDark: isDark,
                ),
                const SizedBox(height: 12),
                _ImageSourceOption(
                  icon: Iconsax.gallery,
                  title: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    // _pickImage(ImageSource.gallery, userController);
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ),
    );
  }

  // Future<void> _pickImage(
  //   ImageSource source,
  //   UserController userController,
  // ) async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(
  //       source: source,
  //       imageQuality: 80,
  //     );

  //     if (image == null) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     }

  //     // Upload the image
  //     await userController.uploadProfilePicture(imagePath: image.path);

  //     setState(() {
  //       _isLoading = false;
  //     });

  //     // Show success message
  //     Get.snackbar(
  //       'Success',
  //       'Profile picture updated successfully',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green.withOpacity(0.1),
  //       colorText: Colors.green,
  //       margin: const EdgeInsets.all(12),
  //       borderRadius: 10,
  //       icon: const Icon(Iconsax.tick_circle, color: Colors.green),
  //     );
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });

  //     // Show error message
  //     Get.snackbar(
  //       'Error',
  //       'Failed to update profile picture: ${e.toString()}',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.withOpacity(0.1),
  //       colorText: Colors.red,
  //       margin: const EdgeInsets.all(12),
  //       borderRadius: 10,
  //       icon: const Icon(Iconsax.warning_2, color: Colors.red),
  //     );
  //   }
  // }

  void _deleteAccount(UserController userController) async {
    final isConfirmed = await Get.dialog<bool>(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirm Account Deletion',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE53935),
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Delete Account',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (isConfirmed == true) {
      try {
        setState(() => _isLoading = true);

        // Change this line to call deleteUserAccount instead of deleteAccount
        await userController.deleteUserAccount();

        setState(() => _isLoading = false);
        Get.offAllNamed('/login');
        Get.snackbar(
          'Account Deleted',
          'Your account has been deleted successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Iconsax.tick_circle, color: Colors.red),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Error',
          'Failed to delete account: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Iconsax.warning_2, color: Colors.red),
        );
      }
    }
  }
}

class _HeaderBar extends StatelessWidget {
  final bool isDark;
  const _HeaderBar({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left_2,
            color: isDark ? Colors.white : Colors.black87,
          ),
          style: IconButton.styleFrom(
            backgroundColor:
                isDark ? Colors.white.withOpacity(0.08) : Colors.black12,
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
          ),
        ),
        const Spacer(),
        Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isDark;
  final bool readOnly;
  final String? helperText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.isDark,
    this.readOnly = false,
    this.helperText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontSize: 15,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText,
          helperStyle: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          filled: true,
          fillColor:
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.02),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _ImageSourceOption({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color:
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
            const SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onDelete;

  const _DeleteAccountButton({required this.isDark, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onDelete,
        style: ElevatedButton.styleFrom(
          // Use a slightly darker red in dark mode for better contrast
          backgroundColor:
              isDark ? const Color(0xFFD32F2F) : const Color(0xFFE53935),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.trash, size: 20),
            const SizedBox(width: 8),
            Text(
              'Delete Account',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
