import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/onboarding_screen.dart';
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
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          width: 120,
          height: 110,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/Logo.png'))),
        ),
      ),
    );
  }
}
