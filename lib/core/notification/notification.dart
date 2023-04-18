import 'package:flutter/material.dart';

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
}