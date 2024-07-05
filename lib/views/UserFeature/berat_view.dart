import 'dart:io';

import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BeratView extends StatefulWidget {
  const BeratView({super.key});

  @override
  State<BeratView> createState() => _BeratViewState();
}

class _BeratViewState extends State<BeratView> {
  late TextEditingController dateCtl = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedOption;
  XFile? selectedImage;

  List<String> options = ['Berat', 'Ringan', 'Sedang'];

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
    weightController.dispose();
    notesController.dispose();
  }

  bool validation() {
    if (selectedImage == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Berat Badan',
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
                'Kenapa pengawasan berat badan penting?',
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
                'Dietku',
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
                    initialDate: now.subtract(const Duration(days: 7)),
                    firstDate: now.subtract(
                        const Duration(days: 7)), // Seminggu yang lalu
                    lastDate: now,
                  );
                  if (dateTime != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(dateTime);
                    setState(() {
                      dateCtl.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: weightController,
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
                        'Kg',
                        style:
                            blackText.copyWith(fontSize: 12, fontWeight: bold),
                      ),
                    ],
                  ),
                  labelText: 'Berat badan',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Foto',
                style: blackText.copyWith(
                  fontSize: 14,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(10),
                  image: selectedImage == null
                      ? null
                      : DecorationImage(
                          image: FileImage(File(selectedImage!.path)),
                          fit: BoxFit.cover,
                        ),
                ),
                child: selectedImage == null
                    ? Center(
                        child: Text(
                          'Dokumentasikan aktivitas dietmu',
                          style: blackText,
                        ),
                      )
                    : null,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: PickImagesButton(
                      icon: Icons.camera_alt,
                      title: 'Kamera',
                      onPressed: () async {
                        final image = await selectCameraImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: PickImagesButton(
                      icon: Icons.photo,
                      title: 'Galeri',
                      onPressed: () async {
                        final image = await selectGalleryImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                  ),
                ],
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
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: () async {
            if (dateCtl.text.isEmpty || weightController.text.isEmpty) {
              Get.snackbar('Error', 'Harap isi semua bagian');
            } else {
              final weight = double.tryParse(weightController.text);
              try {
                await TugasServices().addBeratData(
                  dateCtl.text,
                  weight!,
                  selectedImage,
                  notesController.text.isNotEmpty ? notesController.text : null,
                );
              } catch (e) {
                Get.snackbar('Error', e.toString());
              }
            }
          },
        ),
      ),
    );
  }
}
