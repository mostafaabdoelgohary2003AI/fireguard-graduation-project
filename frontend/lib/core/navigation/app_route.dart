import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:fire_gaurd/core/models/event_model.dart';
import 'package:fire_gaurd/feature/alert/presentation/screen/alert_screen.dart';
import 'package:fire_gaurd/feature/auth/forgot_password_screen.dart';
import 'package:fire_gaurd/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:fire_gaurd/feature/auth/signup/presentation/screen/signup_screen.dart';
import 'package:fire_gaurd/feature/cameras/presentation/screen/cameras_screen.dart';
import 'package:fire_gaurd/feature/home/presentation/screen/home_screen.dart';
import 'package:fire_gaurd/feature/notification/presentation/screen/notification_screen.dart';
import 'package:fire_gaurd/feature/settings/presentation/screen/settings_screen.dart';
import 'package:fire_gaurd/feature/splash/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRoute = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path:    '/',
      name:    AppRouteConstants.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path:    '/login',
      name:    AppRouteConstants.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path:    '/signup',
      name:    AppRouteConstants.singup,
      builder: (_, __) => const SignupScreen(),
    ),
    GoRoute(
      path:    '/forgotPassword',
      name:    AppRouteConstants.forgotPassword,
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path:    '/home',
      name:    AppRouteConstants.home,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path:    '/cameras',
      name:    AppRouteConstants.cameras,
      builder: (_, __) => const CamerasScreen(),
    ),
    GoRoute(
      path:    '/history',
      name:    AppRouteConstants.notification,
      builder: (_, __) => const NotificationScreen(),
    ),
    GoRoute(
      path:    '/alert',
      name:    AppRouteConstants.alert,
      // Pass the EventModel via GoRouter's `extra` parameter:
      //   context.pushNamed(AppRouteConstants.alert, extra: event);
      builder: (_, state) => AlertScreen(
        event: state.extra as EventModel?,
      ),
    ),
    GoRoute(
      path:    '/settings',
      name:    AppRouteConstants.settings,
      builder: (_, __) => const SettingsScreen(),
    ),
  ],
);
