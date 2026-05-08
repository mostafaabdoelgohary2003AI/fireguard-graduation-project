import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/app_route_constant.dart';
import '../../../../core/services/auth_service.dart';
import '../widgets/splash_loading_indicator.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_title.dart';
import '../../../../core/widgets/spacing_widget.dart';

/// Checks the stored token and redirects to Home or Login accordingly.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Brief pause for the splash animation.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final loggedIn = await AuthService.isLoggedIn();
    if (!mounted) return;

    context.goNamed(
      loggedIn ? AppRouteConstants.home : AppRouteConstants.login,
    );
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
