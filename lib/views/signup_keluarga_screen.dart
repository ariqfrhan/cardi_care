import 'package:cardi_care/routes.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupKeluargaScreen extends StatelessWidget {
  const SignupKeluargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              const SizedBox(
                height: 20,
              ),
              const Column(
                children: [
                  CustomFormField(
                    title: 'Nama Lengkap',
                  ),
                  CustomFormField(
                    title: 'Email',
                  ),
                  CustomFormField(
                    title: 'Kata Sandi',
                    obscureText: true,
                  ),
                  CustomFormField(
                    title: 'Konfirmasi Kata Sandi',
                    obscureText: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 81,
              ),
              CustomRedButton(
                title: 'Daftar',
                onPressed: () {
                  Get.toNamed(Routes.onboarding);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
