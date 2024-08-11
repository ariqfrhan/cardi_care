import 'package:cardi_care/model/rokok_alkohol_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/internet_controller.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MerokokAlkoholView extends StatefulWidget {
  const MerokokAlkoholView({super.key});

  @override
  State<MerokokAlkoholView> createState() => _MerokokAlkoholViewState();
}

class _MerokokAlkoholViewState extends State<MerokokAlkoholView> {
  final TextEditingController notesController = TextEditingController();
  String? selectedOptionRokok;
  String? selectedOptionAlkohol;
  String? selectedOption;

  List<String> options = [
    'Ya',
    'Tidak',
  ];
  List<String> keteranganOptions = [
    'Mandiri',
    'Keluarga bantu mengingatkan untuk\nmengurangi/berhenti'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Merokok & Alkohol',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Apakah hari ini anda merokok?',
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(
                  color: redColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              value: selectedOptionRokok,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOptionRokok = newValue;
                });
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Apakah hari ini anda mengonsumsi alkohol?',
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(
                  color: redColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              value: selectedOptionAlkohol,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOptionAlkohol = newValue;
                });
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Keterangan',
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(color: redColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              items: keteranganOptions.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InternetControllerWidget(
          builder: (context, isConnected) {
            return CustomRedButton(
              title: 'Simpan',
              onPressed: () async {
                if (selectedOptionAlkohol == null ||
                    selectedOptionRokok == null ||
                    selectedOption == null) {
                  Get.snackbar('Error', 'Harap isi semua bagian');
                } else {
                  if (isConnected) {
                    RokokAlkoholModel rokok = RokokAlkoholModel(
                      id: '',
                      userId: '',
                      date: DateTime.now().toIso8601String(),
                      merokok: selectedOptionRokok!,
                      alkohol: selectedOptionAlkohol!,
                      notes: selectedOption,
                    );

                    await TugasServices().addRokokAlkoholData(rokok);
                    Get.offAllNamed(Routes.mainWrapper);
                  } else {
                    Get.offAllNamed(Routes.mainWrapper);
                    Get.snackbar(
                        'Sukses', 'Akan mengupdate data setelah online');
                    RokokAlkoholModel rokok = RokokAlkoholModel(
                      id: '',
                      userId: '',
                      date: DateTime.now().toIso8601String(),
                      merokok: selectedOptionRokok!,
                      alkohol: selectedOptionAlkohol!,
                      notes: selectedOption,
                    );
                    await TugasServices().addRokokAlkoholData(rokok);
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
