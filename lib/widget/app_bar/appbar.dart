import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/utils/constants/sizes.dart';

/// Custom AppBar widget that implements PreferredSizeWidget
class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor with optional parameters for customization
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  /// Title widget for the AppBar
  final Widget? title;

  /// Whether to show the default back arrow
  final bool showBackArrow;

  /// Custom leading icon (if back arrow is not shown)
  final IconData? leadingIcon;

  /// List of action widgets to display on the right
  final List<Widget>? actions;

  /// Callback for leading icon press
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Adds horizontal padding to the AppBar
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false, // Prevents default back button
        leading:
            // If showBackArrow is true, show the default back arrow
            showBackArrow
                ? IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Iconsax.arrow_left),
                )
                // If a custom leading icon is provided, show it
                : leadingIcon != null
                ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
                // Otherwise, no leading widget
                : null,
        title: title, // Sets the title widget
        actions: actions, // Sets the action widgets
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
