import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fire_gaurd/core/services/api_service.dart';
import 'package:fire_gaurd/core/services/endpoints.dart';
import 'package:fire_gaurd/core/navigation/app_route.dart';
import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:fire_gaurd/core/models/notification_payload.dart';
import 'package:fire_gaurd/core/services/database_service.dart';

// Top-level function to handle background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");

  // 1. Initialize Firebase if needed (already handled by main if app is starting,
  // but background isolates might need it)
  // 2. Save to Database
  final alert = AlertPayload.fromMap(message.data);
  if (alert.type == 'fire_alert') {
    await DatabaseService.instance.insertNotification(alert);

    // 3. Show the notification with the custom sound manually
    // This is required because 'data-only' messages don't show a notification by default

    const android = AndroidNotificationDetails(
      'fire_emergency_v3',
      'Fire Emergency Alerts',
      channelDescription: 'High priority fire detection alerts',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('fire_alarm'),
      playSound: true,
    );

    // Use a simplified manual show for background consistency
    final FlutterLocalNotificationsPlugin backgroundLocal =
        FlutterLocalNotificationsPlugin();

    // Explicitly initialize the local notifications plugin in the background isolate
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await backgroundLocal.initialize(initSettings);

    // For background, we use the same title/body logic
    final String title = message.notification?.title ?? "FIRE ALERT DETECTED";
    final String body =
        message.notification?.body ??
        "Emergency at ${alert.cameraName} (${alert.location})";

    await backgroundLocal.show(
      message.hashCode,
      title,
      body,
      const NotificationDetails(
        android: android,
        iOS: DarwinNotificationDetails(sound: 'fire_alarm.mp3'),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

class FirebaseNotifications {
  final FirebaseMessaging _fbm = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Stream to broadcast alerts to the UI
  static final StreamController<AlertPayload> _notificationStreamController =
      StreamController<AlertPayload>.broadcast();
  static Stream<AlertPayload> get notificationStream =>
      _notificationStreamController.stream;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'fire_emergency_v3', // Incrementing version to force sound refresh
    'Fire Emergency Alerts',
    description: 'High priority fire detection alerts',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('fire_alarm'),
  );

  Future<void> initNotifications() async {
    // Request permission for iOS and Android
    await _fbm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Set background messaging handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize local notifications for foreground alerts
    await _initLocalNotifications();

    // Initialize foreground and interactive handlers
    _setupForegroundMessage();
    _setupInteractedMessage();
  }

  /// Sends the current FCM token to the backend.
  /// Call this after Login, Signup, or when the app auto-logs in.
  Future<void> sendTokenToBackend() async {
    String? token = await _fbm.getToken();
    log("FCM Token for registration: $token");

    if (token != null) {
      try {
        final apiService = ApiService();
        await apiService.post(Endpoints.testPushNotification, {
          'token': token,
          'platform': Platform.isAndroid ? 'android' : 'ios',
        });
        log("Token registered to backend successfully.");
      } catch (e) {
        log("Failed to register token: $e");
      }
    }
  }

  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          final message = RemoteMessage(data: jsonDecode(payload));
          _handleRouting(message);
        }
      },
    );

    final platform = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await platform?.createNotificationChannel(_channel);
  }

  // Handle notifications when the app is in the Foreground
  void _setupForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      // 1. Broadcast via stream for active UI observers
      final alert = AlertPayload.fromMap(message.data);
      if (alert.type == 'fire_alert') {
        DatabaseService.instance.insertNotification(alert);
        _notificationStreamController.add(alert);
      }

      // 2. Show a local notification so it appears in the system tray
      final notification = message.notification;
      if (notification != null) {
        _showLocalNotification(message);
      } else if (message.data.isNotEmpty) {
        // Even if there's no "notification" object, show one manually for "data" messages
        _showLocalNotification(message);
      }
    });
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    // Unified content for both Data-only and Notification messages
    final String title = notification?.title ?? "FIRE ALERT DETECTED";
    final String body =
        notification?.body ??
        "Emergency at ${data['camera_name'] ?? 'Unknown Camera'} (${data['location'] ?? 'Unknown Location'})";

    _localNotifications.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
          sound: const RawResourceAndroidNotificationSound('fire_alarm'),
          playSound: true,
        ),
      ),
      payload: jsonEncode(data),
    );
  }

  // Handle taps on the notification (Background and Terminated states)
  Future<void> _setupInteractedMessage() async {
    // 1. App is Terminated: Get the message that opened the app
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      _handleRouting(initialMessage);
    }

    // 2. App is in Background: Listen for when the app is opened via a notification tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRouting);
  }

  // Centralized routing based on notification payload data
  void _handleRouting(RemoteMessage message) {
    log("Handling route for message: ${message.data}");

    final alert = AlertPayload.fromMap(message.data);

    // Save to DB (especially important for background/terminated taps)
    if (alert.type == 'fire_alert') {
      DatabaseService.instance.insertNotification(alert);
    }

    // Navigate using the global appRoute instance
    if (alert.type == 'fire_alert') {
      // Check if we are already on the alert screen to avoid stacking
      final String currentLocation =
          appRoute.routerDelegate.currentConfiguration.last.matchedLocation;

      if (currentLocation == '/alert') {
        appRoute.goNamed(AppRouteConstants.alert, extra: alert);
      } else {
        appRoute.pushNamed(AppRouteConstants.alert, extra: alert);
      }
    } else {
      appRoute.pushNamed(AppRouteConstants.notification);
    }
  }

  // Cleanup
  void dispose() {
    _notificationStreamController.close();
  }
}
