import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignupPasienScreen extends StatefulWidget {
  const SignupPasienScreen({super.key});

  @override
  State<SignupPasienScreen> createState() => _SignupPasienScreenState();
}

class _SignupPasienScreenState extends State<SignupPasienScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthServices _authServices = AuthServices();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    title: 'Nama Lengkap',
                    controller: _nameController,
                  ),
                  CustomFormField(
                    title: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dobController,
                          decoration: InputDecoration(
                              fillColor: pinkColor,
                              labelText: 'Tanggal',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: const Icon(Icons.date_range),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: redColor))),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime now = DateTime.now();
                            DateTime? dateTime = await showDatePicker(
                              context: context,
                              firstDate:
                                  now.subtract(const Duration(days: 36500)),
                              lastDate: now,
                            );
                            if (dateTime != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(dateTime);
                              setState(() {
                                _dobController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomFormField(
                          title: 'Jenis Kelamin',
                          controller: _genderController,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          title: 'Tinggi Badan',
                          controller: _heightController,
                          suffixText: 'cm',
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomFormField(
                          title: 'Berat Badan',
                          controller: _weightController,
                          suffixText: 'kg',
                        ),
                      )
                    ],
                  ),
                  CustomFormField(
                    title: 'Kata Sandi',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  CustomFormField(
                    title: 'Konfirmasi Kata Sandi',
                    obscureText: true,
                    controller: _confirmPasswordController,
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
                      _confirmPasswordController.text) {
                    UserModel user = UserModel(
                      uid: '',
                      name: _nameController.text,
                      email: _emailController.text,
                      tempatTL: _dobController.text,
                      gender: _genderController.text,
                      height: _heightController.text,
                      weight: _weightController.text,
                    );

                    await _authServices.signUpWithEmail(
                      _emailController.text,
                      _passwordController.text,
                      user,
                    );
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
