import 'dart:async';
import 'dart:ui' show Color;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constant/api_constants.dart';
import '../models/event_model.dart';
import 'api_service.dart';
import 'auth_service.dart';

// ── Background FCM handler (must be a top-level function) ──────────────────

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // Firebase is already initialized before this is called.
  // We cannot touch UI here; just show a local notification.
  await NotificationService._showLocalNotification(message);
}

// ── Channel constants ─────────────────────────────────────────────────────
// Channel id MUST match what the backend sends in fcm.py:
//   AndroidNotification(channel_id='alerts')

const String _channelId   = 'alerts';
const String _channelName = 'Fire Alerts';
const String _channelDesc = 'Emergency fire and smoke detection alerts';

/// Manages Firebase Cloud Messaging and local notification display.
///
/// Call [NotificationService.initialize()] once in main() after
/// Firebase.initializeApp() completes.
///
/// Listen to [NotificationService.alertStream] to receive parsed
/// [EventModel] objects whenever a fire/smoke alert arrives.
class NotificationService {
  NotificationService._();

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  // Stream that the app listens to for triggering emergency navigation.
  static final StreamController<EventModel> _alertController =
      StreamController<EventModel>.broadcast();
  static Stream<EventModel> get alertStream => _alertController.stream;

  // ── Init ────────────────────────────────────────────────────────────────

  static Future<void> initialize() async {
    // 1 — Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    // 2 — Init flutter_local_notifications
    await _initLocalNotifications();

    // 3 — Request permission (iOS + Android 13+)
    await _requestPermissions();

    // 4 — Handle messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 5 — App opened from a background notification tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 6 — App was terminated; opened via notification tap
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _handleNotificationTap(initial);
  }

  // ── FCM token ──────────────────────────────────────────────────────────

  /// Retrieves the FCM token and registers it with the backend.
  /// Call this after a successful login.
  static Future<void> registerFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;

      await ApiService.post(
        ApiConstants.registerDevice,
        data: {'token': token, 'platform': defaultTargetPlatform.name.toLowerCase()},
      );
      debugPrint('NotificationService: FCM token registered');
    } catch (e) {
      debugPrint('NotificationService: token registration failed: $e');
    }
  }

  /// Removes the FCM token from the backend on logout.
  static Future<void> unregisterFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;

      await ApiService.delete(
        ApiConstants.unregisterDevice,
        data: {'token': token},
      );
    } catch (e) {
      debugPrint('NotificationService: token unregister failed: $e');
    }
  }

  // ── Message handlers ───────────────────────────────────────────────────

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('NotificationService: foreground message: ${message.data}');

    // Show a local notification banner so the user sees it even in-app.
    await _showLocalNotification(message);

    // Push the parsed event into the stream so the app can navigate.
    final event = _parseEvent(message);
    if (event != null) _alertController.add(event);
  }

  static void _handleNotificationTap(RemoteMessage message) {
    final event = _parseEvent(message);
    if (event != null) _alertController.add(event);
  }

  // ── Local notification ────────────────────────────────────────────────

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? _titleFromData(message.data);
    final body  = notification?.body  ?? _bodyFromData(message.data);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance:    Importance.max,
      priority:      Priority.high,
      enableVibration: true,
      playSound:     true,
      fullScreenIntent: true,
      icon:          '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
        interruptionLevel: InterruptionLevel.critical,
      ),
    );

    await _localNotifications.show(
      message.hashCode,
      title,
      body,
      details,
      payload: message.data['event_id']?.toString(),
    );
  }

  static Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create the high-priority alert channel (Android 8+).
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description:      _channelDesc,
      importance:       Importance.max,
      playSound:        true,
      enableVibration:  true,
      enableLights:     true,
      ledColor:         Color(0xFFFF0000),
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _requestPermissions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert:       true,
      badge:       true,
      sound:       true,
      criticalAlert: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void _onLocalNotificationTap(NotificationResponse response) {
    // When tapped, the app will be brought to foreground; the alert stream
    // will be triggered by the FCM handlers if the payload carries an event_id.
    debugPrint('NotificationService: local notification tapped: ${response.payload}');
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static EventModel? _parseEvent(RemoteMessage message) {
    final data = message.data;
    final type = data['type']?.toString() ?? '';
    if (!type.contains('alert')) return null; // skip 'test' or 'event_resolved'
    try {
      return EventModel.fromFcmData(data);
    } catch (e) {
      debugPrint('NotificationService: could not parse event: $e');
      return null;
    }
  }

  static String _titleFromData(Map<String, dynamic> data) {
    final type = data['event_type']?.toString() ?? 'fire';
    return type == 'smoke' ? '💨 Smoke Detected!' : '🔥 Fire Detected!';
  }

  static String _bodyFromData(Map<String, dynamic> data) {
    final loc  = data['location']      ?? 'Unknown location';
    final zone = data['zone']          ?? '';
    final conf = data['ai_confidence'] ?? '0';
    return '$loc${zone.isNotEmpty ? " — $zone" : ""} — ${double.tryParse(conf.toString())?.toStringAsFixed(1) ?? conf}% confidence';
  }
}
