import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import '../routes/app_routes.dart';
import '../../data/services/auth_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showDefaultLogo = true;
  Timer? _switchTimer;

  @override
  void initState() {
    super.initState();

    // Toggle logo setiap 400ms
    _switchTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (mounted) {
        setState(() {
          _showDefaultLogo = !_showDefaultLogo;
        });
      }
    });

    _goNext();
  }

  Future<void> _goNext() async {
    final authService = AuthService();
    final loggedIn = await authService.isLoggedIn();

    // Minimal splash 2 detik
    await Future.delayed(const Duration(seconds: 2));

    _switchTimer?.cancel();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      loggedIn ? AppRoutes.home : AppRoutes.login,
    );
  }

  @override
  void dispose() {
    _switchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Logo default
                    Image.asset(
                      'assets/logos/tmbd-default.png',
                      width: 140,
                      height: 169,
                    )
                        .animate()
                        .fade(
                          duration: 300.ms,
                          curve: Curves.easeInOut,
                          begin: _showDefaultLogo ? 1.0 : 0.0,
                          end: _showDefaultLogo ? 1.0 : 0.0,
                        )
                        .scale(
                          duration: 300.ms,
                          curve: Curves.elasticOut,
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.0, 1.0),
                        ),

                    // Logo variant
                    Image.asset(
                      'assets/logos/tmbd-variant.png',
                      width: 140,
                      height: 169,
                    )
                        .animate()
                        .fade(
                          duration: 300.ms,
                          curve: Curves.easeInOut,
                          begin: _showDefaultLogo ? 0.0 : 1.0,
                          end: _showDefaultLogo ? 0.0 : 1.0,
                        )
                        .scale(
                          duration: 300.ms,
                          curve: Curves.elasticOut,
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.0, 1.0),
                        ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Image.asset(
                'assets/logos/tiketux.png',
                width: 83.59,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
