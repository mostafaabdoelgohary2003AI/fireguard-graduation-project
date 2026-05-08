import 'package:fire_gaurd/core/constant/app_route_constant.dart';
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
import '../../../../../core/widgets/spacing_widget.dart';
import '../widgets/forgot_password_button.dart';
import '../widgets/no_account_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final provider = context.read<AuthProvider>();
    provider.clearError();

    final ok = await provider.login(
      _usernameController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;
    if (ok) {
      context.goNamed(AppRouteConstants.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthLogo(),
              const VerticalSpace(16),
              const AuthTitle(title: AppStrings.loginTitle),
              const VerticalSpace(48),

              AuthTextField(
                label: 'Username',
                controller: _usernameController,
                prefixIcon: Icons.person_outline_rounded,
                hintText: 'Enter your username',
              ),
              const VerticalSpace(24),
              AuthTextField(
                label: AppStrings.password,
                controller: _passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const VerticalSpace(8),
              const ForgotPasswordButton(),
              const VerticalSpace(24),

              // Error message
              Consumer<AuthProvider>(
                builder: (_, provider, __) {
                  if (provider.error == null) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: AppColors.danger.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              color: AppColors.danger, size: 18.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              provider.error!,
                              style: TextStyle(
                                  color: AppColors.danger,
                                  fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Login button
              Consumer<AuthProvider>(
                builder: (_, provider, __) => AppButton(
                  text: AppStrings.signIn,
                  type: AppButtonType.primary,
                  isLoading: provider.isLoading,
                  onPressed: provider.isLoading ? null : _onLogin,
                ),
              ),

              const VerticalSpace(24),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
