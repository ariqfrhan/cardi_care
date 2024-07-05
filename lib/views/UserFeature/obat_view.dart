import 'package:cardi_care/model/obat_model.dart';
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

  Future<void> _saveUpdates() async {
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
        await TugasServices().addRiwayatObatPasienData(updatedObat);
      }
    }
    Get.snackbar('Success', 'Data obat berhasil diperbarui');
    _fetchObatData();
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
                Text(
                  'Kenapa obat penting?',
                  style: blackText.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
                  style: blackText.copyWith(
                    fontSize: 12,
                  ),
                ),
                _buildObatSection('Pagi (06.00-10.00)', 6, 10),
                _buildObatSection('Siang (12.00-15.00)', 12, 15),
                _buildObatSection('Malam (18.00-20.00)', 18, 20),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: _saveUpdates,
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
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 8),
          ...filteredObat.map((obat) {
            return ObatForms(
              namaObat: obat.nama,
              jam: obat.date.hour,
              onOptionChanged: (value) {
                _handleOptionChanged(obat.id, value!);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
