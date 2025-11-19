import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSetting {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _handleTap(response.payload!);
        }
      },
    );

    // Request permission (Android 13+, iOS)
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _initFirebaseMessaging();
  }

  static Future<void> _initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? 'New Message';
      final body = message.notification?.body ?? 'You have a new notification';
      final payload = jsonEncode(message.data);

      showNotification(id: DateTime.now().millisecondsSinceEpoch ~/ 1000, title: title, body: body, payload: payload);
    });

    // Background → tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final payload = jsonEncode(message.data);
      _handleTap(payload);
    });

    // Terminated → tapped
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      final payload = jsonEncode(initialMessage.data);
      _handleTap(payload);
    }
  }

  /// 🔹 Handle tap on notification
  static void _handleTap(String payload) {
    try {
      final data = jsonDecode(payload);
      final screen = data['screen'];
      if (screen == 'taskDetails') {
        final taskId = data['taskId'];
        debugPrint("[Notification] 🚪 Navigate to Task ID: $taskId");
        // TODO: Navigation add karo with Get.to()
      }
    } catch (_) {
      debugPrint("[Notification] ⚠️ Invalid payload: $payload");
    }
  }

  /// 🔹 Show local notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_channel',
      'Push Notifications',
      channelDescription: 'Channel for push notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(id, title, body, details, payload: payload);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
