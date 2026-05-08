import 'package:firebase_core/firebase_core.dart';
import 'package:fire_gaurd/fire_gaurd.dart';
import 'package:flutter/material.dart';

import 'core/services/api_service.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1 — Firebase (required for FCM)
  //     Add google-services.json to android/app/ before this compiles.
  await Firebase.initializeApp();

  // 2 — Dio HTTP client
  ApiService.initialize();

  // 3 — Notification channels + FCM listeners
  await NotificationService.initialize();

  runApp(const FireGaurd());
}
