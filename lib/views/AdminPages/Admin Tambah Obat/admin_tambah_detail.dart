import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AdminTambahDetail extends StatefulWidget {
  const AdminTambahDetail({super.key});

  @override
  State<AdminTambahDetail> createState() => _AdminTambahDetailState();
}

class _AdminTambahDetailState extends State<AdminTambahDetail> {
  final TextEditingController namaController = TextEditingController();
  final UserModel user = Get.arguments;
  bool pagi = false;
  bool siang = false;
  bool sore = false;
  bool malam = false;

  void _save() async {
    DateTime now = DateTime.now();
    List<DateTime> selectedTimes = [];

    if (pagi) {
      selectedTimes.add(DateTime(now.year, now.month, now.day, 7, 0));
    }
    if (siang) {
      selectedTimes.add(DateTime(now.year, now.month, now.day, 12, 0));
    }
    if (sore) {
      selectedTimes.add(DateTime(now.year, now.month, now.day, 15, 0));
    }
    if (malam) {
      selectedTimes.add(DateTime(now.year, now.month, now.day, 19, 0));
    }

    if (selectedTimes.isNotEmpty) {
      await TugasServices()
          .addObatData(namaController.text, selectedTimes, user.uid)
          .then((value) async {
        Get.offNamed(Routes.adminObatDetail, arguments: user);
      });
    }
  }

  int _count() {
    int count = 0;
    if (pagi) count++;
    if (siang) count++;
    if (sore) count++;
    if (malam) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        leading: ZoomTapAnimation(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Tambah obat',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: pinkColor,
                hintText: 'Nama Obat',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: redColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Frekuensi'),
                ),
                Expanded(
                  flex: 1,
                  child: Text('${_count()} kali / hari'),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              title: const Text('Pagi'),
              value: pagi,
              onChanged: (bool? value) {
                setState(() {
                  pagi = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Siang'),
              value: siang,
              onChanged: (bool? value) {
                setState(() {
                  siang = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sore'),
              value: sore,
              onChanged: (bool? value) {
                setState(() {
                  sore = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Malam'),
              value: malam,
              onChanged: (bool? value) {
                setState(() {
                  malam = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: () {
            _save();
          },
        ),
      ),
    );
  }
}
