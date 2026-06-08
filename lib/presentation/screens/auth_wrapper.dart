import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'splash_screen.dart';
import '../pages/main_navigation_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.status == AuthStatus.uninitialized) {
      return const SplashScreen();
    }
    if (auth.status == AuthStatus.authenticated) {
      return const MainNavigationPage();
    }
    return const Scaffold(body: Center(child: Text('الرجاء تسجيل الدخول')));
  }
}
