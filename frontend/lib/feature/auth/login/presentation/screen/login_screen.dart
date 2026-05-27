import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:fire_gaurd/feature/auth/login/presentation/widgets/forgot_password_button.dart';
import 'package:fire_gaurd/feature/auth/provider/auth_provider.dart';
import 'package:fire_gaurd/feature/auth/widgets/auth_logo.dart';
import 'package:fire_gaurd/feature/auth/widgets/auth_text_field.dart';
import 'package:fire_gaurd/feature/auth/widgets/auth_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import 'package:fire_gaurd/core/widgets/spacing_widget.dart';
import '../widgets/no_account_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    
    await authProvider.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (context.mounted) {
      if (authProvider.status == AuthStatus.authenticated) {
        context.goNamed(AppRouteConstants.home);
      } else if (authProvider.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login failed'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthLogo(),
                const VerticalSpace(16),
                const AuthTitle(title: AppStrings.loginTitle),
                const VerticalSpace(48),
                AuthTextField(
                  label: "Username",
                  controller: _emailController,
                  prefixIcon: Icons.person_outline_rounded,
                  hintText: "Enter your username",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(24),
                AuthTextField(
                  label: AppStrings.password,
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  hintText: AppStrings.passwordHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(8),
                const ForgotPasswordButton(),
                const VerticalSpace(32),
                Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return AppButton(
                      text: AppStrings.signIn,
                      type: AppButtonType.primary,
                      isLoading: auth.isLoading,
                      onPressed: () => _handleLogin(context),
                    );
                  },
                ),
                const VerticalSpace(24),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
