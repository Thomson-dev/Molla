import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Simple fullscreen loader utility used as `TFullScreenLoader`.
/// Usage:
///   await TFullScreenLoader.openLoadingDialog('Logging you in...');
///   ...
///   TFullScreenLoader.stopLoading();
class TFullScreenLoader {
  TFullScreenLoader._();

  static bool _isOpen = false;

  /// Open a fullscreen, non-dismissible loading dialog.
  /// If a loader is already open this is a no-op.
  static void openLoadingDialog([String? message]) {
    if (_isOpen) return;
    _isOpen = true;

    // Use Get.dialog so we don't need a BuildContext
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(minWidth: 120, maxWidth: 320),
              decoration: BoxDecoration(
                color: Get.theme.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Close the loader if it's open.
  static void stopLoading() {
    if (!_isOpen) return;
    _isOpen = false;
    try {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      } else {
        // Fallback: attempt to pop once
        Get.back();
      }
    } catch (_) {
      // ignore errors when popping
    }
  }
}
