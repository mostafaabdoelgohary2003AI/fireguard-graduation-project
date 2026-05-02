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

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'admin@fireguard.com');
    _passwordController = TextEditingController(text: '..........');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
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
                  label: AppStrings.username,
                  controller: _emailController,
                  prefixIcon: Icons.mail_outline_rounded,
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
                const VerticalSpace(32),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return AppButton(
                      text: AppStrings.signIn,
                      type: AppButtonType.primary,
                      isLoading: authProvider.isLoading,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (authProvider.isLoading) return;

                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter email and password')),
                          );
                          return;
                        }

                        final success = await authProvider.login(email, password);

                        if (context.mounted) {
                          if (success) {
                            context.goNamed(AppRouteConstants.home);
                          } else if (authProvider.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(authProvider.errorMessage!),
                                backgroundColor: AppColors.danger,
                              ),
                            );
                          }
                        }
                      },
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
