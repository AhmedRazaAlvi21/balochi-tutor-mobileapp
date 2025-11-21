import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? deviceToken;
  static Future<void> initFCM() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("✅ Notification permission granted");
    } else {
      debugPrint("⚠️ Notification permission denied");
    }

    // Get initial token
    deviceToken = await _messaging.getToken();
    debugPrint("📱 FCM Device Token: $deviceToken");

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint("🔄 Token refreshed: $newToken");
      deviceToken = newToken;
    });
  }
}
