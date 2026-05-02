import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:fire_gaurd/feature/alert/presentation/screen/alert_screen.dart';
import 'package:fire_gaurd/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:fire_gaurd/feature/auth/signup/presentation/screen/signup_screen.dart';
import 'package:fire_gaurd/feature/cameras/presentation/screen/cameras_screen.dart';
import 'package:fire_gaurd/feature/home/presentation/screen/home_screen.dart';
import 'package:fire_gaurd/feature/notification/presentation/screen/notification_screen.dart';
import 'package:fire_gaurd/feature/settings/presentation/screen/settings_screen.dart';
import 'package:fire_gaurd/feature/splash/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRoute = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: AppRouteConstants.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/login",
      name: AppRouteConstants.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/Singup",
      name: AppRouteConstants.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: "/home",
      name: AppRouteConstants.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/livecamere",
      name: AppRouteConstants.cameras,
      builder: (context, state) => const CamerasScreen(),
    ),
    GoRoute(
      path: "/notification",
      name: AppRouteConstants.notification,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: "/alert",
      name: AppRouteConstants.alert,
      builder: (context, state) => const AlertScreen(),
    ),
    GoRoute(
      path: "/settings",
      name: AppRouteConstants.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
