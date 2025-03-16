import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:potential/app/utils/constants/radius.dart';
import 'package:potential/app/utils/constants/spacing.dart';

class Alerts {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    String cancelText = "Cancel",
    String? animationAsset,
    bool isBottomSheet = false,
    bool autoDismiss = false,
    Duration autoDismissDuration = const Duration(seconds: 5),
    AlertType type = AlertType.info,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    String? asset = _getAnimationAsset(type, animationAsset);
    if (isBottomSheet) {
      return showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.mediumLarge)),
        ),
        builder: (BuildContext bottomSheetContext) {
          return _buildDialogContent(
            context: bottomSheetContext,
            title: title,
            message: message,
            confirmText: confirmText,
            cancelText: cancelText,
            animationAsset: asset,
            onConfirm: onConfirm,
            onCancel: onCancel,
          );
        },
      );
    } else {
      Future.delayed(autoDismissDuration, () {
        if (autoDismiss && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
            contentPadding: const EdgeInsets.all(AppSpacing.mediumLarge),
            title: Text(title),
            content: _buildDialogContent(
              context: dialogContext,
              title: title,
              message: message,
              confirmText: confirmText,
              cancelText: cancelText,
              animationAsset: asset,
              onConfirm: onConfirm,
              onCancel: onCancel,
            ),
          );
        },
      );
    }
  }

  static Widget _buildDialogContent({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    String? animationAsset,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (animationAsset != null) Lottie.asset(animationAsset, height: 120, width: 120),
        const SizedBox(height: 10),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
              child: Text(
                cancelText,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(
                confirmText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String? _getAnimationAsset(AlertType type, String? customAsset) {
    if (customAsset != null) return customAsset;
    switch (type) {
      case AlertType.success:
        return 'assets/animations/success.json';
      case AlertType.warning:
        return 'assets/animations/warning.json';
      case AlertType.error:
        return 'assets/animations/error.json';
      default:
        return null;
    }
  }
}

enum AlertType { success, warning, error, info }
