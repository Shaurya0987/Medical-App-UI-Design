import 'package:bdver/signUp.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MinimalLoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Use a curved animation for smoother effect
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut, // you can change to easeIn, easeOut, etc.
            );
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:Color(0xFF4B6C68),
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
