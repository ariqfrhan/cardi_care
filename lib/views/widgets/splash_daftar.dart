// ignore_for_file: use_build_context_synchronously

import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/KeluargaPages/KeluargaWrapper/keluarga_wrapper_screen.dart';
import 'package:cardi_care/views/home_wrapper/main_wrapper_screen.dart';
import 'package:cardi_care/views/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashDaftar extends StatefulWidget {
  const SplashDaftar({super.key});

  @override
  State<SplashDaftar> createState() => _SplashDaftarState();
}

class _SplashDaftarState extends State<SplashDaftar> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainWrapperScreen()),
        );
        return;
      }
      DocumentSnapshot keluargaSnapshot = await FirebaseFirestore.instance
          .collection('keluarga')
          .doc(user.uid)
          .get();

      if (keluargaSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => KeluargaWrapperScreen()),
        );
        return;
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 220,
              height: 199,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/daftar.png'))),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              'Pendaftaran Akun Berhasil',
              style: blackText.copyWith(fontSize: 32, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Jangan khawatir! Data kamu aman dengan kami.',
              style: blackText.copyWith(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
