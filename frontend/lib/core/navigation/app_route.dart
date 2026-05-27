import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:fire_gaurd/core/models/camera_model.dart';
import 'package:fire_gaurd/feature/alert/presentation/screen/alert_screen.dart';
import 'package:fire_gaurd/feature/auth/forgot_password_screen.dart';
import 'package:fire_gaurd/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:fire_gaurd/feature/auth/signup/presentation/screen/signup_screen.dart';
import 'package:fire_gaurd/feature/cameras/presentation/screen/cameras_screen.dart';
import 'package:fire_gaurd/feature/cameras/presentation/screen/camera_detail_screen.dart';
import 'package:fire_gaurd/feature/cameras/presentation/screen/edit_camera_screen.dart';
import 'package:fire_gaurd/feature/home/presentation/screen/home_screen.dart';
import 'package:fire_gaurd/feature/activity/presentation/screen/activity_history_screen.dart';
import 'package:fire_gaurd/feature/settings/presentation/screen/settings_screen.dart';
import 'package:fire_gaurd/feature/settings/presentation/screen/profile_screen.dart';
import 'package:fire_gaurd/feature/splash/presentation/screen/splash_screen.dart';
import 'package:fire_gaurd/core/models/notification_payload.dart';
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
      name: AppRouteConstants.singup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: "/forgotPassword",
      name: AppRouteConstants.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
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
      path: "/camera/:id",
      name: AppRouteConstants.cameraDetails,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CameraDetailScreen(cameraId: id);
      },
    ),
    GoRoute(
      path: "/editCamera",
      name: AppRouteConstants.editCamera,
      builder: (context, state) {
        final camera = state.extra as Camera;
        return EditCameraScreen(camera: camera);
      },
    ),
    GoRoute(
      path: "/activityHistory",
      name: AppRouteConstants.activityHistory,
      builder: (context, state) => const ActivityHistoryScreen(),
    ),
    GoRoute(
      path: "/alert",
      name: AppRouteConstants.alert,
      builder: (context, state) {
        final payload = state.extra as AlertPayload?;
        return AlertScreen(payload: payload);
      },
    ),
    GoRoute(
      path: "/settings",
      name: AppRouteConstants.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: "/profile",
      name: AppRouteConstants.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
