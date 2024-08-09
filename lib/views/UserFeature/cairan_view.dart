import 'dart:io';

import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CairanView extends StatefulWidget {
  const CairanView({super.key});

  @override
  State<CairanView> createState() => _CairanViewState();
}

class _CairanViewState extends State<CairanView> {
  late TextEditingController dateCtl = TextEditingController();
  final TextEditingController spoonController = TextEditingController();
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
    spoonController.dispose();
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
          'Pembatasan Cairan',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: 20,
                ),
                TextFormField(
                  controller: spoonController,
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
<<<<<<< Updated upstream
                          'Sendok teh',
=======
                          'Gelas',
>>>>>>> Stashed changes
                          style: blackText.copyWith(
                              fontSize: 12, fontWeight: bold),
                        ),
                      ],
                    ),
                    labelText: 'Jumlah Garam',
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
                            'Fotokan gelas yang digunakan',
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
<<<<<<< Updated upstream
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: () async {
            if (dateCtl.text.isEmpty || spoonController.text.isEmpty) {
              Get.snackbar('Error', 'Harap isi semua bagian');
            } else {
              final spoon = double.tryParse(spoonController.text);
              try {
                await TugasServices().addCairanData(
                  dateCtl.text,
                  spoon!,
                  selectedImage,
                  notesController.text.isNotEmpty ? notesController.text : null,
                );
                Get.offAllNamed(Routes.mainWrapper);
              } catch (e) {
                Get.snackbar('Error', e.toString());
              }
            }
=======
        child: InternetControllerWidget(
          builder: (context, isConnected) {
            return CustomRedButton(
              title: 'Simpan',
              onPressed: () async {
                if (dateCtl.text.isEmpty ||
                    spoonController.text.isEmpty ||
                    selectedImage == null) {
                  Get.snackbar('Error', 'Harap isi semua bagian');
                } else {
                  final spoon = double.tryParse(spoonController.text);
                  try {
                    if (isConnected) {
                      await TugasServices().addCairanData(
                        dateCtl.text,
                        spoon!,
                        selectedImage,
                        notesController.text.isNotEmpty
                            ? notesController.text
                            : null,
                      );
                      Get.offAllNamed(Routes.mainWrapper);
                    } else {
                      Get.offAllNamed(Routes.mainWrapper);
                      await TugasServices().addCairanData(
                        dateCtl.text,
                        spoon!,
                        selectedImage,
                        notesController.text.isNotEmpty
                            ? notesController.text
                            : null,
                      );
                      Get.snackbar(
                          'Sukses', 'Akan mengupdate data ketika online');
                    }
                  } catch (e) {
                    Get.snackbar('Error', e.toString());
                  }
                }
              },
            );
>>>>>>> Stashed changes
          },
        ),
      ),
    );
  }
}
