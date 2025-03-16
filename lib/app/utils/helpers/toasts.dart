import 'package:flutter/material.dart';
import 'package:potential/app/utils/constants/radius.dart';
import 'package:potential/app/utils/constants/spacing.dart';

class ToastHelper {
  static void showToast(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: _buildToast(context, message),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static Widget _buildToast(BuildContext context, String message) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium, vertical: AppSpacing.mediumSmall),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isDarkTheme ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.2),
            blurRadius: AppRadius.extraSmall,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off, color: isDarkTheme ? Colors.white : Colors.black),
          const SizedBox(width: AppSpacing.mediumSmall),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
