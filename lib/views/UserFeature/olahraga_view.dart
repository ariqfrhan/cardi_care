import 'package:cardi_care/model/olahraga_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/internet_controller.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OlahragaView extends StatefulWidget {
  const OlahragaView({super.key});

  @override
  State<OlahragaView> createState() => _OlahragaViewState();
}

class _OlahragaViewState extends State<OlahragaView> {
  late TextEditingController dateCtl = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController activityController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedOption;
  String? selectedOptionAktivitas;

  
  List<String> aktivitasOptions = ['Jalan', 'Renang', 'Bulutangkis'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Aktivitas',
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
                'Kenapa aktivitas fisik?',
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
              Text(
                'Aktivitasku',
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
                  labelText: 'Tanggal',
                  suffixIcon: const Icon(Icons.date_range),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                    ),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime now = DateTime.now();
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: now.add(const Duration(days: 7)),
                  );
                  if (dateTime != null) {
                    DateTime selectedDateTime = DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      now.hour,
                      now.minute,
                      now.second,
                    );
                    String iso8601String = selectedDateTime.toIso8601String();
                    setState(() {
                      dateCtl.text = iso8601String;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis olahraga',
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
              TextFormField(
                controller: activityController,
                decoration: InputDecoration(
                  labelText: 'List aktivitas',
                  filled: true,
                  fillColor: pinkColor,
                  floatingLabelStyle: TextStyle(color: redColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                    ),
                  ),
                  hintText: 'Klik icon untuk memilih list aktivitas',
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      setState(() {
                        activityController.text = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return aktivitasOptions.map((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedOptionAktivitas = value;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: durationController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: pinkColor,
                  floatingLabelStyle: TextStyle(color: redColor),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: redColor)),
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Menit',
                        style:
                            blackText.copyWith(fontSize: 12, fontWeight: bold),
                      ),
                    ],
                  ),
                  labelText: 'Durasi Olahraga',
                ),
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
        child: InternetControllerWidget(
          builder: (context, isConnected) {
            return CustomRedButton(
              title: 'Simpan',
              onPressed: () async {
                if (dateCtl.text.isEmpty ||
                    selectedOption == null ||
                    durationController.text.isEmpty ||
                    activityController.text.isEmpty) {
                  Get.snackbar('Error', 'Harap isi semua bagian');
                } else {
                  if (isConnected) {
                    OlahragaModel olahraga = OlahragaModel(
                      id: '',
                      userId: '',
                      date: dateCtl.text,
                      type: selectedOption!,
                      activity: activityController.text,
                      duration: durationController.text,
                      notes: notesController.text.isNotEmpty
                          ? notesController.text
                          : null,
                    );
                    Get.offAllNamed(Routes.mainWrapper);
                    await TugasServices().addOlahragaData(olahraga);
                  } else {
                    Get.offAllNamed(Routes.mainWrapper);
                    Get.snackbar(
                        'Sukses', 'Akan mengupdate data setelah online');
                    OlahragaModel olahraga = OlahragaModel(
                      id: '',
                      userId: '',
                      date: dateCtl.text,
                      type: selectedOption!,
                      activity: activityController.text,
                      duration: durationController.text,
                      notes: notesController.text.isNotEmpty
                          ? notesController.text
                          : null,
                    );
                    await TugasServices().addOlahragaData(olahraga);
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
