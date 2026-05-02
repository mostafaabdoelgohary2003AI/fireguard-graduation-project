import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/app_route_constant.dart';
import '../provider/splash_provider.dart';
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
    _nextScreen();
  }

  void _nextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    context.goNamed(AppRouteConstants.login);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider()..initialize(),
      child: Scaffold(
        body: Consumer<SplashProvider>(
          builder: (context, provider, child) {
            return SizedBox(
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
            );
          },
        ),
      ),
    );
  }
}
