import 'package:cardi_care/model/rokok_alkohol_model.dart';
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

  List<String> options = [
    'Ya',
    'Tidak',
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
            Text(
              'Kenapa alkohol penting?',
              style: blackText.copyWith(
                fontSize: 18,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
              style: blackText.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
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
              height: 8,
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
              height: 8,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Catatan',
              style: blackText.copyWith(
                fontSize: 14,
                fontWeight: semibold,
              ),
            ),
            TextFormField(
              controller: notesController,
              maxLines: 2,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: pinkColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  floatingLabelStyle: TextStyle(color: redColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: redColor)),
                  hintText: 'Tambahkan catatan disini'),
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
                    selectedOptionRokok == null) {
                  Get.snackbar('Error', 'Harap isi semua bagian');
                } else {
                  if (isConnected) {
                    RokokAlkoholModel rokok = RokokAlkoholModel(
                      id: '',
                      userId: '',
                      date: DateTime.now().toIso8601String(),
                      merokok: selectedOptionRokok!,
                      alkohol: selectedOptionAlkohol!,
                      notes: notesController.text.isNotEmpty
                          ? notesController.text
                          : null,
                    );

                    await TugasServices().addRokokAlkoholData(rokok);
                  } else {}
                }
              },
            );
          },
        ),
      ),
    );
  }
}
