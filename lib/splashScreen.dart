import 'package:bdver/homePage.dart';
import 'package:bdver/signUp.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  void _navigateUser() async {
    // Wait for splash duration
    await Future.delayed(const Duration(seconds: 3));

    // Check if user already logged in
    final session = Supabase.instance.client.auth.currentSession;

    Widget nextScreen;

    if (session != null) {
      // User already logged in → go to Home
      nextScreen = MainScreen();
    } else {
      // Not logged in → go to Login
      nextScreen = const MinimalLoginPage();
    }

    // Navigate with fade transition
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return FadeTransition(
            opacity: fade,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF4B6C68),
        child: Center(
          child: Text(
            "Splash",
            style: TextStyle(
              fontFamily: 'Inspiration',
              fontSize: 80,
              fontWeight: FontWeight.w700,
              color: Colors.orange.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
