import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../services/app_router/app_router.dart';

enum NotificationMode {
  warning,
  error,
  message
}

class AppNotification {
  AppNotification._();

  static showSnackBar({
    NotificationMode notificationMode = NotificationMode.message,
    Duration duration = const Duration(milliseconds: 700),
    required String message}) {
    ScaffoldMessenger.of(AppRouter.context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: duration,
        )
    );
  }

  static showAlertDialog({required String message, required VoidCallback onAccept, required VoidCallback onCancel}) {
    showDialog(
        context: AppRouter.navigatorKey.currentState!.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.primaryBackground,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.primaryWhite),
              ),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    AppRouter.pop();
                    onCancel();
                  },
                  child: const Text('Cancel', style: TextStyle(color: AppColors.primaryWhite))),
              MaterialButton(
                  onPressed: () async {
                    AppRouter.pop();
                    onAccept();
                  },
                  child: const Text('Ok', style: TextStyle(color: AppColors.primaryWhite)))
            ],
          );
        });
  }
}