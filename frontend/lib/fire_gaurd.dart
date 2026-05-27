import 'package:fire_gaurd/core/navigation/app_route.dart';
import 'package:fire_gaurd/core/services/api_service.dart';
import 'package:fire_gaurd/core/theme/app_theme.dart';
import 'package:fire_gaurd/feature/auth/data/repository/auth_repository.dart';
import 'package:fire_gaurd/feature/auth/provider/auth_provider.dart';
import 'package:fire_gaurd/feature/cameras/data/repository/camera_repository.dart';
import 'package:fire_gaurd/feature/cameras/presentation/provider/camera_provider.dart';
import 'package:fire_gaurd/feature/home/presentation/provider/home_provider.dart';
import 'package:fire_gaurd/feature/activity/data/repository/activity_repository.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FireGaurd extends StatelessWidget {
  const FireGaurd({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        ProxyProvider<ApiService, AuthRepository>(
          update: (_, apiService, __) => AuthRepository(apiService),
        ),
        ProxyProvider<ApiService, CameraRepository>(
          update: (_, apiService, __) => CameraRepository(apiService),
        ),
        ProxyProvider<ApiService, ActivityRepository>(
          update: (_, apiService, __) => ActivityRepository(apiService),
        ),
        ChangeNotifierProvider<CameraProvider>(
          create: (context) => CameraProvider(
            cameraRepository: context.read<CameraRepository>(),
          ),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<ActivityProvider>(
          create: (context) => ActivityProvider(
            repository: context.read<ActivityRepository>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: appRoute,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
