import 'package:cardi_care/model/KeluargaModel/keluarga_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupKeluargaScreen extends StatefulWidget {
  const SignupKeluargaScreen({super.key});

  @override
  State<SignupKeluargaScreen> createState() => _SignupKeluargaScreenState();
}

class _SignupKeluargaScreenState extends State<SignupKeluargaScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirPasswordController =
      TextEditingController();

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
              Column(
                children: [
                  CustomFormField(
                    controller: _namaController,
                    title: 'Nama Lengkap',
                  ),
                  CustomFormField(
                    controller: _emailController,
                    title: 'Email',
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    title: 'Kata Sandi',
                    obscureText: true,
                  ),
                  CustomFormField(
                    controller: _confirPasswordController,
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
                onPressed: () async {
                  if (_passwordController.text ==
                      _confirPasswordController.text) {
                    KeluargaModel keluargaModel = KeluargaModel(
                      uid: '',
                      name: _namaController.text,
                      userIds: [],
                      email: _emailController.text,
                    );

                    await AuthServices().keluargaSignUp(
                      _emailController.text,
                      _passwordController.text,
                      keluargaModel,
                    );
                    Get.snackbar('Registration Success', 'Registrasi berhasil');
                    Get.offAllNamed(Routes.splashDaftar);
                  } else {
                    Get.snackbar(
                        'Registration Failed', 'Password tidak sesuai');
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
