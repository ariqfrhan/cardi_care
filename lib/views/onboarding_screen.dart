import 'package:cardi_care/routes.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Column(
                  children: [
                    Container(
                      width: 110,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Logo.png')),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Selamat datang di CACA',
                      style: blackText.copyWith(
                          fontSize: 32, fontWeight: semibold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'CACA (Cardiac Care) memudahkan kepatuhan perawatan diri anda',
                      textAlign: TextAlign.center,
                      style:
                          blackText.copyWith(fontWeight: medium, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.signAs),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        'Daftar',
                        style:
                            whiteText.copyWith(fontWeight: bold, fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.signinAs),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        'Masuk',
                        style:
                            whiteText.copyWith(fontWeight: bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
