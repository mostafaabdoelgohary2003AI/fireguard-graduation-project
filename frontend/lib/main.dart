import 'package:fire_gaurd/core/services/cache_helper.dart';
import 'package:fire_gaurd/core/services/firebase_notifications.dart';
import 'package:fire_gaurd/fire_gaurd.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fire_gaurd/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await CacheHelper.init();
  await FirebaseNotifications().initNotifications();
  runApp(const FireGaurd());
}
