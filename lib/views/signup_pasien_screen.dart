import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class SignupPasienScreen extends StatelessWidget {
  const SignupPasienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        children: [
          const SizedBox(
            height: 56,
          ),
          Text(
            'Data Diri',
            textAlign: TextAlign.center,
            style: blackText.copyWith(
              fontSize: 32,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Lengkapi data diri anda untuk membuat akun',
            textAlign: TextAlign.center,
            style: blackText.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
        ],
      ),
    );
  }
}
