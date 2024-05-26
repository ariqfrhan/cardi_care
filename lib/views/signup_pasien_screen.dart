import 'package:cardi_care/routes.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPasienScreen extends StatelessWidget {
  const SignupPasienScreen({super.key});

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
              Container(
                child: Column(
                  children: [
                    const CustomFormField(
                      title: 'Nama Lengkap',
                    ),
                    const CustomFormField(
                      title: 'Email',
                    ),
                    const CustomFormField(
                      title: 'Tanggal Lahir',
                    ),
                    Row(
                      children: [
                        const CustomFormField(
                          title: 'Tinggi',
                        ),
                      ],
                    ),
                    const CustomFormField(
                      title: 'Kata Sandi',
                      obscureText: true,
                    ),
                    const CustomFormField(
                      title: 'Konfirmasi Kata Sandi',
                      obscureText: true,
                    ),
                  ],
                ),
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
