import 'package:fire_gaurd/core/navigation/app_route.dart';
import 'package:fire_gaurd/core/theme/app_theme.dart';
import 'package:fire_gaurd/feature/alert/presentation/provider/alert_provider.dart';
import 'package:fire_gaurd/feature/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/// Root widget.
///
/// [AuthProvider] and [AlertProvider] are global — they must persist
/// across navigation and screen rebuilds, so they live at the app root.
class FireGaurd extends StatelessWidget {
  const FireGaurd({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthStatus()),
        ChangeNotifierProvider(create: (_) => AlertProvider()),
      ],
      child: ScreenUtilInit(
        designSize:      const Size(360, 690),
        minTextAdapt:    true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp.router(
          routerConfig:              appRoute,
          debugShowCheckedModeBanner: false,
          theme:                     AppTheme.lightTheme,
        ),
      ),
    );
  }
}
