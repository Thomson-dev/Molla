import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/common/widgets/shimmer/shimmer_effect.dart';
import 'package:molla/features/authentication/controllers/user/user_controller.dart';

import 'package:molla/features/authentication/repositories/authentication_repository.dart';
import 'package:molla/features/authentication/controllers/setting/setting.controller.dart';
// Import authentication repository

import 'package:molla/features/authentication/screens/profile/profileScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;

    // Get the settings controller
    final settingsController = Get.find<SettingsController>();
    final controller = Get.put(UserController());

    return Obx(() {
      // Get the current theme state
      final isDark = settingsController.isDarkMode;

      return Scaffold(
        backgroundColor: Colors.transparent, // Important for gradient to show
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isDark
                      ? [const Color(0xFF0D0E12), const Color(0xFF1A1C20)]
                      : [const Color(0xFFF9FAFB), const Color(0xFFEFF1F4)],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    /// 🔹 Profile Header
                    _ProfileHeader(isDark: isDark),

                    const SizedBox(height: 30),

                    /// 🔹 Account Section
                    _SectionHeader(title: "Account", isDark: isDark),
                    _SettingCard(
                      icon: Iconsax.user,
                      title: "My Profile",
                      subtitle: "Manage your personal information",
                      onTap: () => Get.to(() => const ProfileScreen()),
                      iconColor: const Color(0xFF0077B6),
                      iconBgColor: const Color(0xFFF0F9FF),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.shopping_bag,
                      title: "My Orders",
                      subtitle: "View and track your orders",
                      onTap: () {},
                      iconColor: const Color(0xFFFF4D6D),
                      iconBgColor: const Color(0xFFFFF0F3),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.location,
                      title: "Addresses",
                      subtitle: "Shipping & billing addresses",
                      trailing: const Text(
                        "2 saved",
                        style: TextStyle(
                          color: Color(0xFF38B000),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {},
                      iconColor: const Color(0xFF38B000),
                      iconBgColor: const Color(0xFFF0FFF4),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.card,
                      title: "Payment Methods",
                      subtitle: "Manage saved cards",
                      onTap: () {},
                      iconColor: const Color(0xFF6C63FF),
                      iconBgColor: const Color(0xFFF0F0FF),
                      isDark: isDark,
                    ),

                    const SizedBox(height: 28),

                    /// 🔹 App Settings
                    _SectionHeader(title: "App Settings", isDark: isDark),

                    // Dark Mode Toggle - Now Connected to Controller
                    _SettingSwitch(
                      icon: isDark ? Iconsax.moon : Iconsax.sun_1,
                      title: "Dark Mode",
                      subtitle: "Use dark theme throughout the app",
                      value: isDark,
                      onChanged: (value) {
                        // Call the controller to toggle theme
                        settingsController.toggleThemeMode();
                      },
                      iconColor:
                          isDark
                              ? const Color(0xFF9E9EFF)
                              : const Color(0xFFFFB300),
                      iconBgColor:
                          isDark
                              ? const Color(0xFF3F3F69)
                              : const Color(0xFFFFF8E1),
                      isDark: isDark,
                    ),

                    // Notification Toggle - Also Connected
                    _SettingSwitch(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subtitle: "Receive push updates & offers",
                      value: settingsController.isNotificationEnabled,
                      onChanged: (value) {
                        settingsController.toggleNotifications();
                      },
                      iconColor: const Color(0xFFE53935),
                      iconBgColor: const Color(0xFFFFEBEE),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.global,
                      title: "Language",
                      subtitle: "Change application language",
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "English",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      onTap: () {},
                      iconColor: const Color(0xFF2E7D32),
                      iconBgColor: const Color(0xFFE8F5E9),
                      isDark: isDark,
                    ),

                    const SizedBox(height: 28),

                    /// 🔹 More
                    _SectionHeader(title: "More", isDark: isDark),
                    _SettingCard(
                      icon: Iconsax.info_circle,
                      title: "About Us",
                      subtitle: "Learn more about our company",
                      onTap: () {},
                      iconColor: const Color(0xFF006064),
                      iconBgColor: const Color(0xFFE0F7FA),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.support,
                      title: "Help & Support",
                      subtitle: "Get assistance and FAQs",
                      trailing: const Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.green,
                      ),
                      onTap: () {},
                      iconColor: const Color(0xFF3949AB),
                      iconBgColor: const Color(0xFFE8EAF6),
                      isDark: isDark,
                    ),
                    _SettingCard(
                      icon: Iconsax.logout,
                      title: "Logout",
                      subtitle: "Sign out of your account",
                      onTap: () => _showLogoutDialog(context, isDark, isSmall),
                      iconColor: Colors.red,
                      iconBgColor: const Color(0xFFFFEBEE),
                      isDark: isDark,
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: Text(
                        "Version 2.4.1 (build 245)",
                        style: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context, bool isDark, bool isSmall) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Logout Dialog',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 30),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E2126) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.logout,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Message
                    Text(
                      'Are you sure you want to logout from your account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  isDark ? Colors.white70 : Colors.black54,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color:
                                      isDark ? Colors.white24 : Colors.black12,
                                ),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Logout button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              _handleLogout(); // Perform logout
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  // Handle logout process
  void _handleLogout() {
    try {
      // Call the AuthenticationRepository logout method
      AuthenticationRepository.instance.logout();
    } catch (e) {
      // Show error message if logout fails
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}

/// =====================
/// Components
/// =====================

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  const _ProfileHeader({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Row(
      children: [
        // Avatar - could also use shimmer here for loading state
        const CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1598550880863-4e8aa3d0edb4?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name with shimmer loading effect
            Obx(() {
              if (controller.profileLoading.value) {
                // Display a shimmer loader while user profile is being loaded
                return TShimmerEffect(width: 150, height: 24);
              } else {
                // Show the user's name when loaded
                return Text(
                  'Hello, ${controller.user.value.firstName}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                );
              }
            }),

            // Membership status - could also use Obx and shimmer here
            Text(
              'Premium Member',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionHeader({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBgColor;
  final bool isDark;
  final Widget? trailing;

  const _SettingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconColor,
    required this.iconBgColor,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? const Color(0xFF1E2126) : Colors.white,
      elevation: isDark ? 1 : 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: iconBgColor,
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Iconsax.arrow_right_3,
                    color: isDark ? Colors.white38 : Colors.grey[400],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color iconColor;
  final Color iconBgColor;
  final bool isDark;

  const _SettingSwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.iconColor,
    required this.iconBgColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? const Color(0xFF1E2126) : Colors.white,
      elevation: isDark ? 1 : 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconBgColor,
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white60 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
