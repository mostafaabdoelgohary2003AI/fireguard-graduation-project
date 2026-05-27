import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../feature/auth/provider/auth_provider.dart';

class AdminOnly extends StatelessWidget {
  final Widget child;
  final Widget replacement;

  const AdminOnly({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    // Check the admin status from AuthProvider
    final isAdmin = context.watch<AuthProvider>().isAdmin;
    
    // If the user is an admin, render the child widget (e.g., Edit/Add buttons).
    // Otherwise, render the replacement (which is empty space by default).
    return isAdmin ? child : replacement;
  }
}
