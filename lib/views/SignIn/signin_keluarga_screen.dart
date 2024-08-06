import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninKeluargaScreen extends StatefulWidget {
  const SigninKeluargaScreen({super.key});

  @override
  State<SigninKeluargaScreen> createState() => _SigninKeluargaScreenState();
}

class _SigninKeluargaScreenState extends State<SigninKeluargaScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                'Masukkan username dan password anda untuk login sebagai keluarga pasien',
                textAlign: TextAlign.center,
                style: blackText.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  CustomFormField(
                    title: 'Email',
                    controller: _emailController,
                  ),
                  CustomFormField(
                    title: 'Kata Sandi',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                ],
              ),
              const SizedBox(
                height: 81,
              ),
              CustomRedButton(
                title: 'Login',
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    Get.snackbar('Error', 'Harap isi email dan password');
                  } else {
                    bool loginSuccess = await AuthServices().logInWithEmail(
                        _emailController.text, _passwordController.text,
                        userType: 'keluarga');
                    if (loginSuccess) {
                      Get.offAllNamed(Routes.keluargaWrapper);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
