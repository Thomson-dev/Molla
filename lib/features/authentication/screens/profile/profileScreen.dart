import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/common/widgets/shimmer/shimmer_effect.dart';
import 'package:molla/features/authentication/controllers/user/user_controller.dart';
import 'package:molla/features/authentication/controllers/setting/setting.controller.dart';
import 'package:molla/features/authentication/screens/profile/editprofile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    final userController = Get.put(UserController());
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;

    return Obx(() {
      final isDark = settingsController.isDarkMode;
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Scaffold(
        backgroundColor: Colors.transparent,
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
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _ProfileAppBar(isDark: isDark),
                    const SizedBox(height: 24),
                    Center(child: _ProfileHeader(isDark: isDark)),
                    const SizedBox(height: 30),
                    _StatsSection(isDark: isDark),
                    const SizedBox(height: 30),

                    Text(
                      'Personal Information',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (userController.profileLoading.value) {
                        return Column(
                          children: [
                            _InfoCardShimmer(isDark: isDark),
                            _InfoCardShimmer(isDark: isDark),
                            _InfoCardShimmer(isDark: isDark),
                            _InfoCardShimmer(isDark: isDark),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _InfoCard(
                              icon: Iconsax.user,
                              title: 'Name',
                              value:
                                  userController.user.value.firstName +
                                  ' ' +
                                  userController.user.value.lastName,
                              isDark: isDark,
                              iconBgColor: colorScheme.tertiaryContainer,
                              iconColor: colorScheme.tertiary,
                            ),
                            _InfoCard(
                              icon: Iconsax.sms,
                              title: 'Email',
                              value: userController.user.value.email,
                              isDark: isDark,
                              iconBgColor: colorScheme.primaryContainer,
                              iconColor: colorScheme.primary,
                            ),

                            _InfoCard(
                              icon: Iconsax.call,
                              title: 'Phone',
                              value:
                                  userController.user.value.phoneNumber.isEmpty
                                      ? 'Not provided'
                                      : userController.user.value.phoneNumber,
                              isDark: isDark,
                              iconBgColor: colorScheme.secondaryContainer,
                              iconColor: colorScheme.secondary,
                            ),
                            _InfoCard(
                              icon: Iconsax.location,
                              title: 'Location',
                              value:
                                  'Not provided', // Add to user model if needed
                              isDark: isDark,
                              iconBgColor: Colors.orange.shade50,
                              iconColor: Colors.orange,
                            ),
                            _InfoCard(
                              icon: Iconsax.calendar,
                              title: 'Date Joined',
                              value: _formatDate(
                                userController.user.value.createdAt,
                              ),
                              isDark: isDark,
                              iconBgColor: Colors.blue.shade50,
                              iconColor: Colors.blue,
                            ),
                          ],
                        );
                      }
                    }),
                    const SizedBox(height: 30),

                    Text(
                      'Account Actions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ActionButton(
                      icon: Iconsax.password_check,
                      label: 'Change Password',
                      onTap: () {},
                      isDark: isDark,
                      iconBgColor: Colors.indigo.shade50,
                      iconColor: Colors.indigo,
                    ),
                    _ActionButton(
                      icon: Iconsax.security_user,
                      label: 'Privacy Settings',
                      onTap: () {},
                      isDark: isDark,
                      iconBgColor: Colors.purple.shade50,
                      iconColor: Colors.purple,
                    ),
                    _ActionButton(
                      icon: Iconsax.card,
                      label: 'Payment Methods',
                      onTap: () {},
                      isDark: isDark,
                      iconBgColor: Colors.red.shade50,
                      iconColor: Colors.red,
                    ),
                    _ActionButton(
                      icon: Iconsax.notification,
                      label: 'Notification Preferences',
                      onTap: () {},
                      isDark: isDark,
                      iconBgColor: Colors.amber.shade50,
                      iconColor: Colors.amber[700]!,
                    ),
                    const SizedBox(height: 40),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: _DeleteAccountButton(isDark: isDark),
                    // ),
                    // const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not available';

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

/// ---------- COMPONENTS ----------

class _ProfileAppBar extends StatelessWidget {
  final bool isDark;
  const _ProfileAppBar({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleButton(
          icon: Iconsax.arrow_left_2,
          onTap: () => Get.back(),
          isDark: isDark,
        ),
        Text(
          'My Profile',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        _CircleButton(
          icon: Iconsax.edit,
          onTap: () => Get.to(() => const EditProfileScreen()),
          isDark: isDark,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onTap,
      icon: Icon(icon, color: isDark ? Colors.white : Colors.black87),
      style: IconButton.styleFrom(
        backgroundColor:
            isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  const _ProfileHeader({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A3DE8), Color(0xFFE47AE6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                final profilePicture = controller.user.value.profilePicture;
                return CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      profilePicture.isNotEmpty
                          ? NetworkImage(profilePicture)
                          : const NetworkImage(
                            'https://images.unsplash.com/photo-1598550880863-4e8aa3d0edb4?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                );
              }),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _CircleButton(
                icon: Iconsax.camera,
                onTap: () {},
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.profileLoading.value) {
            return Column(
              children: [
                TShimmerEffect(width: 200, height: 28),
                const SizedBox(height: 10),
                TShimmerEffect(width: 150, height: 20),
              ],
            );
          } else {
            return Column(
              children: [
                Text(
                  '${controller.user.value.firstName} ${controller.user.value.lastName}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A3DE8), Color(0xFFE47AE6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6A3DE8).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.crown_1, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Premium Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }
}

class _InfoCardShimmer extends StatelessWidget {
  final bool isDark;
  const _InfoCardShimmer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDark ? 1.0 : 1.5,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? const Color(0xFF1E2126) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            TShimmerEffect(width: 40, height: 40, radius: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(width: 60, height: 12),
                  const SizedBox(height: 8),
                  TShimmerEffect(width: 120, height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  final bool isDark;
  const _StatsSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            count: '12',
            label: 'Orders',
            icon: Iconsax.bag_2,
            iconColor: const Color(0xFF6A3DE8),
            bgColor: const Color(0xFFF0EAFF),
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            count: '5',
            label: 'Wishlist',
            icon: Iconsax.heart,
            iconColor: const Color(0xFFE47AE6),
            bgColor: const Color(0xFFFFF0FB),
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            count: '230',
            label: 'Points',
            icon: Iconsax.coin,
            iconColor: const Color(0xFFFFB800),
            bgColor: const Color(0xFFFFF8E1),
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final bool isDark;

  const _StatCard({
    required this.count,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF292C35) : bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            count,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;
  final Color iconBgColor;
  final bool isDark;
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
    required this.iconBgColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDark ? 1.0 : 1.5,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? const Color(0xFF1E2126) : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isDark ? iconColor.withOpacity(0.2) : iconBgColor,
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBgColor;
  final bool isDark;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.iconColor,
    required this.iconBgColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDark ? 0.8 : 1.0,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? const Color(0xFF1E2126) : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    isDark ? iconColor.withOpacity(0.2) : iconBgColor,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                color: isDark ? Colors.white38 : Colors.black26,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final bool isDark;
  const _DeleteAccountButton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Iconsax.trash, color: Color(0xFFE53935)),
      label: const Text(
        'Delete Account',
        style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE53935), width: 1),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => _showDeleteDialog(context, isDark),
    );
  }

  void _showDeleteDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: isDark ? const Color(0xFF1E2126) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFFFEBEE),
                  child: Icon(Iconsax.warning_2, color: Color(0xFFE53935)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Delete Account',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            content: Text(
              'This action cannot be undone. All your data will be permanently deleted.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Delete logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
