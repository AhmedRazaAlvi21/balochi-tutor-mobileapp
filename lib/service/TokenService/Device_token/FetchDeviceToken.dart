// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
//
// Future<String?> fetchDeviceToken() async {
//   try {
//     String? deviceToken = await FirebaseMessaging.instance.getToken();
//     if (deviceToken == null) {
//       throw Exception("Token is null. Ensure Firebase is properly configured.");
//     }
//     debugPrint("Fetched Device Token: $deviceToken");
//     return deviceToken;
//   } catch (e) {
//     debugPrint("Error fetching device token: $e");
//     return null;
//   }
// }
