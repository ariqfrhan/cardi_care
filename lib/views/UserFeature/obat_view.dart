import 'package:cardi_care/model/obat_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/internet_controller.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObatView extends StatefulWidget {
  const ObatView({super.key});

  @override
  State<ObatView> createState() => _ObatViewState();
}

class _ObatViewState extends State<ObatView> {
  late TextEditingController dateCtl = TextEditingController();
  String? userId;
  List<ObatModel> obatList = [];
  Map<String, String> updatedStatuses = {};

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      await _fetchObatData();
    }
  }

  Future<void> _fetchObatData() async {
    if (userId != null) {
      try {
        obatList = await TugasServices().getObatDataByUserId(userId!);
        setState(() {});
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  List<ObatModel> _filterObatByTime(
      List<ObatModel> obatList, int startHour, int endHour) {
    return obatList.where((obat) {
      int hour = obat.date.hour;
      return hour >= startHour && hour < endHour;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController();
    _loadUserData();
  }

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
  }

  void _handleOptionChanged(String obatId, String newValue) {
    setState(() {
      updatedStatuses[obatId] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Meminum Obat',
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
                _buildObatSection('Pagi (07.00-12.00)', 7, 12),
                _buildObatSection('Siang (12.00-15.00)', 12, 15),
                _buildObatSection('Sore (15.00-19.00)', 15, 19),
                _buildObatSection('Malam (19.00-00.00)', 19, 24),
              ],
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
                if (isConnected) {
                  Get.offAllNamed(Routes.mainWrapper);
                  for (var obat in obatList) {
                    if (updatedStatuses.containsKey(obat.id)) {
                      final status = updatedStatuses[obat.id]!;
                      final updatedObat = ObatModel(
                        id: obat.id,
                        userId: obat.userId,
                        nama: obat.nama,
                        date: obat.date,
                        status: status,
                      );
                      await TugasServices()
                          .addRiwayatObatPasienData(updatedObat);
                    }
                  }
                  Get.snackbar('Success', 'Data obat berhasil diperbarui');
                } else {
                  Get.offAllNamed(Routes.mainWrapper);
                  Get.snackbar('Sukses', 'Akan mengupdate data setelah online');
                  for (var obat in obatList) {
                    if (updatedStatuses.containsKey(obat.id)) {
                      final status = updatedStatuses[obat.id]!;
                      final updatedObat = ObatModel(
                        id: obat.id,
                        userId: obat.userId,
                        nama: obat.nama,
                        date: obat.date,
                        status: status,
                      );
                      await TugasServices()
                          .addRiwayatObatPasienData(updatedObat);
                    }
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildObatSection(String title, int startHour, int endHour) {
    List<ObatModel> filteredObat =
        _filterObatByTime(obatList, startHour, endHour);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackText.copyWith(
              fontSize: 14,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 8),
          ...filteredObat.map((obat) {
            return Column(
              children: [
                ObatForms(
                  namaObat: obat.nama,
                  jam: obat.date.hour,
                  onOptionChanged: (value) {
                    _handleOptionChanged(obat.id, value!);
                  },
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            );
            // ignore: unnecessary_to_list_in_spreads
          }).toList(),
        ],
      ),
    );
  }
}
