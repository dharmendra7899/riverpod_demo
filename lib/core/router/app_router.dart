import 'package:flutter/material.dart';
import 'package:riverpod_demo/presentation/screen/otp_screen.dart';
import 'package:riverpod_demo/presentation/screen/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return _fadeRoute(const SplashScreen(), settings);
      case '/otp':
        return _fadeRoute(const OtpScreen(), settings);
      case '/':
      default:
        return _fadeRoute(const SplashScreen(), settings);
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }





}
