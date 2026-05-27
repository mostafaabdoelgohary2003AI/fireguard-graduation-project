import 'package:fire_gaurd/feature/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/app_route_constant.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_title.dart';
import '../widgets/splash_loading_indicator.dart';
import '../../../../core/widgets/spacing_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  void _handleStartup() async {
    final authProvider = context.read<AuthProvider>();
    
    // Minimal splash time
    await Future.delayed(const Duration(seconds: 2));

    await authProvider.getProfile();

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      context.goNamed(AppRouteConstants.home);
    } else {
      context.goNamed(AppRouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(flex: 3),
            SplashLogo(),
            VerticalSpace(24),
            SplashTitle(),
            Spacer(flex: 2),
            SplashLoadingIndicator(),
            VerticalSpace(48),
          ],
        ),
      ),
    );
  }
}
