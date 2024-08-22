import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? selectedGender;
  final TextEditingController _pressureController = TextEditingController();
  final TextEditingController _pjController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthServices _authServices = AuthServices();

  List<DocumentSnapshot> familyMembers = [];
  List<DocumentSnapshot> filteredFamilyMembers = [];
  DocumentSnapshot? selectedFamilyMember;
  List<String> jenisKelamin = ['Laki-Laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    fetchFamilyMembers();
    _pjController.addListener(() {
      filterFamilyMembers(_pjController.text);
    });
  }

  Future<void> fetchFamilyMembers() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('keluarga').get();
    setState(() {
      familyMembers = snapshot.docs.where((doc) {
        var userIds = doc['userIds'];
        return userIds == null ||
            (userIds is List && (userIds.isEmpty || userIds[0] == null));
      }).toList();
      filteredFamilyMembers = List.from(familyMembers);
    });
  }

  void filterFamilyMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFamilyMembers = List.from(familyMembers);
      } else {
        filteredFamilyMembers = familyMembers.where((doc) {
          return doc['email']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
      if (filteredFamilyMembers.isEmpty) {
        selectedFamilyMember = null;
      }
    });
  }

  List<DropdownMenuEntry<DocumentSnapshot?>> _buildDropdownMenuEntries() {
    if (_pjController.text.isEmpty) {
      return familyMembers
          .map<DropdownMenuEntry<DocumentSnapshot?>>(
            (DocumentSnapshot document) => DropdownMenuEntry<DocumentSnapshot?>(
              value: document,
              label: document['email'] as String,
            ),
          )
          .toList();
    } else if (filteredFamilyMembers.isNotEmpty) {
      return filteredFamilyMembers
          .map<DropdownMenuEntry<DocumentSnapshot?>>(
            (DocumentSnapshot document) => DropdownMenuEntry<DocumentSnapshot?>(
              value: document,
              label: document['email'] as String,
            ),
          )
          .toList();
    } else {
      return [
        const DropdownMenuEntry<DocumentSnapshot?>(
          value: null,
          label: 'No results found',
        ),
      ];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _pressureController.dispose();
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
                  DropdownMenu<DocumentSnapshot?>(
                    menuHeight: 300,
                    width: double.infinity,
                    controller: _pjController,
                    enableFilter: true,
                    requestFocusOnTap: true,
                    label: const Text('Nama Penanggung Jawab'),
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: redColor),
                      ),
                      floatingLabelStyle: TextStyle(color: redColor),
                      labelStyle: TextStyle(color: mono600),
                    ),
                    onSelected: (DocumentSnapshot? newValue) {
                      setState(() {
                        selectedFamilyMember = newValue;
                        if (selectedFamilyMember == null) {
                          _pjController.clear();
                        }
                      });
                    },
                    dropdownMenuEntries: _buildDropdownMenuEntries(),
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      fillColor: pinkColor,
                      labelText: 'Tanggal lahir',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: const Icon(Icons.date_range),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: redColor),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime now = DateTime.now();
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: now.subtract(const Duration(days: 36500)),
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomFormField(
                        title: 'Tekanan darah',
                        suffixText: "mmHg",
                        controller: _pressureController,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: pinkColor,
                            labelText: 'Jenis Kelamin',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: redColor),
                                borderRadius: BorderRadius.circular(12)),
                            floatingLabelStyle: TextStyle(color: redColor),
                          ),
                          value: selectedGender,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          items: jenisKelamin.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
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
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomFormField(
                          title: 'Berat Badan',
                          controller: _weightController,
                          suffixText: 'kg',
                        ),
                      ),
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
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _dobController.text.isEmpty ||
                      selectedFamilyMember == null) {
                    Get.snackbar('Error', 'Harap lengkapi semua data');
                  } else {
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      UserModel user = UserModel(
                        uid: '',
                        familyId: selectedFamilyMember != null
                            ? selectedFamilyMember!.id
                            : '',
                        name: _nameController.text,
                        email: _emailController.text,
                        tempatTL: _dobController.text,
                        bloodPressure: _pressureController.text,
                        gender: selectedGender!,
                        height: _heightController.text,
                        weight: _weightController.text,
                      );

                      await _authServices.signUpWithEmail(
                        _emailController.text,
                        _passwordController.text,
                        user,
                      );

                      if (selectedFamilyMember != null) {
                        await FirebaseFirestore.instance
                            .collection('keluarga')
                            .doc(selectedFamilyMember!.id)
                            .update({
                          'userIds': FieldValue.arrayUnion([user.uid]),
                        });
                      }
                    } else {
                      Get.snackbar(
                          'Registration Failed', 'Password tidak sesuai');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
