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
import '../widgets/already_have_account_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    
    await authProvider.register(userData: {
      'username': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
      'password2': _confirmPasswordController.text,
    });

    if (context.mounted) {
      if (authProvider.status == AuthStatus.authenticated) {
        context.goNamed(AppRouteConstants.home);
      } else if (authProvider.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Registration failed'),
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
                const AuthTitle(title: AppStrings.signUpTitle),
                const VerticalSpace(32),

                AuthTextField(
                  label: AppStrings.fullName,
                  controller: _nameController,
                  prefixIcon: Icons.person_outline_rounded,
                  hintText: "John Doe",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(16),

                AuthTextField(
                  label: AppStrings.email,
                  controller: _emailController,
                  prefixIcon: Icons.mail_outline_rounded,
                  hintText: AppStrings.emailHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(16),

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
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(16),

                AuthTextField(
                  label: AppStrings.confirmPassword,
                  controller: _confirmPasswordController,
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  isConfirmPassword: true,
                  hintText: AppStrings.passwordHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                ),
                const VerticalSpace(32),

                Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return AppButton(
                      text: AppStrings.signUp,
                      type: AppButtonType.primary,
                      isLoading: auth.isLoading,
                      onPressed: () => _handleSignup(context),
                    );
                  },
                ),
                const VerticalSpace(24),
                const AlreadyHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
