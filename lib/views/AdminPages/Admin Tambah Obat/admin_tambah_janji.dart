import 'package:cardi_care/model/janji_temu_model.dart';
import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminTambahJanji extends StatefulWidget {
  const AdminTambahJanji({super.key});

  @override
  State<AdminTambahJanji> createState() => _AdminTambahJanjiState();
}

class _AdminTambahJanjiState extends State<AdminTambahJanji> {
  final UserModel user = Get.arguments;

  late TextEditingController dateCtl = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        dateCtl.text = selectedDateTime.toIso8601String();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Tambah Janji Temu',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah janji temu untuk ${user.name}',
                style: blackText.copyWith(
                  fontSize: 18,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Tambahkan waktu dan catatan mengenai aktivitas janji temu untuk pasien',
                style: blackText.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Waktu',
                style: blackText.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: dateCtl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: pinkColor,
                  labelText: 'Tanggal dan Waktu',
                  suffixIcon: const Icon(Icons.date_range),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                    ),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDateTime(context);
                },
              ),
              const SizedBox(
                height: 8,
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
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: () async {
            if (dateCtl.text.isEmpty) {
              Get.snackbar('Error', 'Harap isi semua bagian');
            } else {
              JanjiTemuModel janjiTemu = JanjiTemuModel(
                id: '',
                userId: user.uid,
                date: dateCtl.text,
                status: notesController.text.isNotEmpty
                    ? notesController.text
                    : null,
              );
              await TugasServices().addJanjiTemu(janjiTemu).then((value) async {
                Get.offNamed(Routes.adminObatDetail, arguments: user);
              });
            }
          },
        ),
      ),
    );
  }
}
